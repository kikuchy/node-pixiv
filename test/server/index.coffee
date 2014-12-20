http = require "http"
qs = require "querystring"
formidable = require "formidable"

one = '"11111","154806","jpg","tite of illustration","12","author name","http://i4.pixiv.net/img-inf/img/2011/10/28/22/32/55/22673807_128x128.jpg",,,"http://i4.pixiv.net/img12/img/author/mobile/22673807_480mw.jpg",,,"2011-10-28 22:32:55","tag1 tag2 tag3",,"33","330","2693","caption of illustration",,,,"22","3","author id",,"0",,,"http://i4.pixiv.net/img12/profile/author/mobile/2047414_80.jpg",'
twenty = (one for i in [1..20]).join "\n"

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
    else if req.url.indexOf "/iphone" == 0
        console.log req.url
        if (req.url.indexOf "/illust.php?") > 1
            res.writeHead 200,
                "Content-Type": "text/plain"
            res.end one
        else if (req.url.indexOf "/search.php?") > 1
            res.writeHead 200,
                "Content-Type": "text/plain"
            res.end twenty
    else
        res.writeHead 404,
            "Content-Type": "text/plain"
        res.end "Not found"
).listen 9000, "127.0.0.1"
