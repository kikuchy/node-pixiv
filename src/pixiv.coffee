API_URL_BASE = "http://spapi.pixiv.net/iphone" or process.env.PIXIV_API_URL_BASE
LOGIN_PAGE_URL = "https://www.secure.pixiv.net/login.php" or process.env.PIXIV_LOGIN_PAGE_URL

Promise = (require "es6-promise").Promise
request = require "request"

Session = require "./session"
{Work}  = require "./work"

makeQuery = (obj) ->
    ("#{encodeURIComponent key}=#{encodeURIComponent obj[key]}" for key of obj).join "&"

pixiv =
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
            url: LOGIN_PAGE_URL
            formData:
                mode: "login"
                pixiv_id: userId
                pass: password
        }, (error, resp, body) ->
            if error
                callback error
            setCookies = resp.headers["set-cookie"]
            sessSetCookie = (setCookies.filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0]
            unless sessSetCookie
                callback "failed to login."
                return
            sessId = (((sessSetCookie.split "; ").filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0].split "=")[1]
            callback null, (new Session sessId)
        )

    getGrapichWork: (callback, session, workId) ->
        params = makeQuery
            p: 1
            illust_id: workId
            "PHPSESSID": session.sessionId
        url = "#{API_URL_BASE}/illust.php?#{params}"
        request.get
            url: url
        , (error, resp, body) ->
            if error
                callback error
            callback null, (Work.parseSingle body)

module.exports = pixiv
