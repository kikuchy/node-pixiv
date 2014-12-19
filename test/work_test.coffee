expect = (require "chai").expect

{Work, IllustWork, MangaWork} = require "../src/work"

illustSample = '"22673808","154806","jpg","tite of illustration","12","author name","http://i4.pixiv.net/img-inf/img/2011/10/28/22/32/55/22673807_128x128.jpg",,,"http://i4.pixiv.net/img12/img/author/mobile/22673807_480mw.jpg",,,"2011-10-28 22:32:55","tag1 tag2 tag3",,"33","330","2693","caption of illustration",,,,"22","3","author id",,"0",,,"http://i4.pixiv.net/img12/profile/author/mobile/2047414_80.jpg",'
mangaSample = '"47513149","220399","png","title of manga","15","author name","http://i1.pixiv.net/c/128x128/img-master/img/2014/12/12/00/45/10/47513148_128x128.jpg",,,"http://i1.pixiv.net/c/480x960/img-master/img/2014/12/12/00/45/10/47513148_480mw.jpg",,,"2014-12-12 00:45:10","tag1 tag2 tag3 tag4",,"611","6080","20350","caption of manga","7",,,"581","19","author id",,"0",,,"http://i1.pixiv.net/img15/profile/author/mobile/6927477_80.jpg",'

describe "Work Parser", () ->
    describe "Single Work Parser", () ->
        it "should choose IllustWork with illustration's CSV", () ->
            iw = Work.parseSingle illustSample
            expect(iw instanceof IllustWork).be.true

        it "should choose MangaWork with manga's CSV", () ->
            mw = Work.parseSingle mangaSample
            expect(mw instanceof MangaWork).be.true
