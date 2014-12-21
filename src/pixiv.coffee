API_URL_BASE = "http://spapi.pixiv.net/iphone"
LOGIN_PAGE_URL = "https://www.secure.pixiv.net/login.php"

request = require "request"

Session = require "./session"
{Work}  = require "./work"

makeQuery = (obj) ->
    ("#{encodeURIComponent key}=#{encodeURIComponent obj[key]}" for key of obj).join "&"

pixiv =
    config:
        endpoints:
            loginPageUrl:   LOGIN_PAGE_URL
            apiBaseUrl:     API_URL_BASE

    createSession: (userId, password, callback) ->
        unless callback
            callback = userId
            userId = null

        userId = userId or process.env.PIXIV_ID
        password = password or process.env.PIXIV_PASS
        unless userId and password
            callback "There is no authenticate data."
            return

        request.post({
            url: pixiv.config.endpoints.loginPageUrl
            formData:
                mode: "login"
                pixiv_id: userId
                pass: password
        }, (error, resp, body) ->
            if error
                callback error
            setCookies = resp.headers["set-cookie"]
            unless setCookies
                callback "failed to login."
                return
            sessSetCookie = (setCookies.filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0]
            unless sessSetCookie
                callback "failed to login."
                return
            sessId = (((sessSetCookie.split "; ").filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0].split "=")[1]
            callback null, (new Session sessId)
        )

    getGrapichWork: (session, workId, callback) ->
        params = makeQuery
            p: 1
            illust_id: workId
            "PHPSESSID": session.sessionId
        url = "#{pixiv.config.endpoints.apiBaseUrl}/illust.php?#{params}"
        request.get
            url: url
        , (error, resp, body) ->
            if error
                callback error
            callback null, (Work.parseSingle body)

    searchWorks: (session, mode, order, pageNo, keyword, callback) ->
        unless session instanceof Session
            callback = keyword
            keyword = pageNo
            pageNo = order
            order = mode
            mode = session
            session = new Session "0"

        params = makeQuery
            p: pageNo
            "PHPSESSID": session.sessionId
            word: keyword
            s_mode: mode
            order: order
        url = "#{pixiv.config.endpoints.apiBaseUrl}/search.php?#{params}"
        request.get url, (error, resp, body) ->
            if error
                callback error
                return
            body = body.slice 0, -1
            callback null, (body.split "\n").map((r) ->
                Work.parseSingle r
            )

module.exports = pixiv
