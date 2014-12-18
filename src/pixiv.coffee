API_URL_BASE = "http://spapi.pixiv.net/iphone"
LOGIN_PAGE_URL = "https://www.secure.pixiv.net/login.php"

Promise = (require "es6-promise").Promise
request = require "request"

Session = require "./session"
{Work}  = require "./work"

makeQuery = (obj) ->
    ret = []
    for key of obj
        ret.push "#{encodeURIComponent key}=#{encodeURIComponent obj[key]}"
    ret.join "&"

pixiv =
    createSession: () ->
        if arguments.length == 0
            return

        callback = arguments[0]
        userId = arguments[1] || process.env.PIXIV_ID
        password = arguments[2] || process.env.PIXIV_PASS
        if (not userId) or (not password)
            callback "There is no authenticate data."

        params =
            mode: "login"
            pixiv_id: userId
            pass: password
        request.post({
            url: LOGIN_PAGE_URL
            formData: params
        }, (error, resp, body) ->
            if error
                callback error
            setCookies = resp.headers["set-cookie"]
            sessSetCookie = (setCookies.filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0]
            sessId = (((sessSetCookie.split "; ").filter (c, i) ->
                return (c.indexOf "PHPSESSID") == 0)[0].split "=")[1]
            callback null, (new Session sessId)
        )

    createSessionPromise: (userId, password) ->
        return new Promise (resolve, reject) ->
            pixiv.createSession (error, session) ->
                if error
                    reject error
                resolve session
            , userId, password

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
            console.log resp
            callback null, (Work.parseSingle body)

    getGrapichWorkPromise: (session, workId) ->
        return new Promise (resolve, reject) ->
            pixiv.getGrapichWork (error, work) ->
                if error
                    reject error
                resolve work
            , session, workId

module.exports = pixiv
