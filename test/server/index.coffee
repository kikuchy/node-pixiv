http = require "http"
qs = require "querystring"
formidable = require "formidable"

(http.createServer (req, res) ->
    if (req.url.indexOf "/login" == 0) and (req.method == "POST")
        form = new formidable.IncomingForm
        form.parse req, (error, fields, files) ->
            console.log fields
            if fields.mode == "login" and fields.pixiv_id == "aaa" and fields.pass == "bbb"
                res.writeHead 200,
                    "Content-Type": "text/html"
                    "Set-Cookie": "PHPSESSID=111111_111111111111111111111111111111; expires=#{(new Date).toUTCString()}; Max-Age=3600; path=/; domain=.pixiv.net"
                    "Expires": "Thu, 19 Nov 1981 08:52:00 GMT"
                    "Location": "http://www.pixiv.net/mypage.php"
                res.end "logined"
            else
                res.writeHead 200,
                    "Content-Type": "text/plain"
                res.end "failed to authenticate"
    else
        res.writeHead 404,
            "Content-Type": "text/plain"
        res.end "Not found"
).listen 9000, "127.0.0.1"
