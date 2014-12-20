expect = (require "chai").expect

pixiv = require "../src/pixiv"
Session = require "../src/session"
damySession = new Session "1111_111111111111111111111111111111"

describe "pixiv Methods", () ->
    before () ->
        pixiv.config.endpoints.loginPageUrl = "http://localhost:9000/login"
        pixiv.config.endpoints.apiBaseUrl = "http://localhost:9000/iphone"

    describe "New Session Creation", () ->
        it "should throw exception when called without ID and password", (done) ->
            pixiv.createSession (error, session) ->
                expect(error).be.ok
                done()

        it "should return new session logining right account", (done) ->
            pixiv.createSession "aaa", "bbb", (error, session) ->
                expect(error).be.not.ok
                expect(session).be.ok
                done()

        it "should return error logining wrong account", (done) ->
            pixiv.createSession "hoge", "fuga", (error, session) ->
                expect(error).be.ok
                done()

    describe "Get Single Work By ID", () ->
        it "should return a work", (done) ->
            pixiv.getGrapichWork damySession, "11111", (error, work) ->
                expect(error).be.not.ok
                expect(work).be.ok
                done()

    describe "Search Works from Keyword", () ->
        it "should return a list of work", (done) ->
            pixiv.searchWorks damySession, "s_tag", "date", 1, "yuri", (error, works) ->
                expect(error).be.not.ok
                expect(works).be.ok
                expect(works.length).be.ok
                done()
