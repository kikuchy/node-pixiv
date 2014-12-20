expect = (require "chai").expect

pixiv = require "../src/pixiv"

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
        damySession =
            sessionId: "1111_111111111111111111111111111111"

        it "should return a work", (done) ->
            pixiv.getGrapichWork damySession, "11111", (error, work) ->
                expect(error).be.not.ok
                expect(work).be.ok
                done()
