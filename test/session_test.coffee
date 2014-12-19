expect = (require "chai").expect

Session = require "../src/session"

describe "Session Object", () ->
    it "should have sessionId property", () ->
        phpsessid = "hogehoge-fugafugafugafuga"
        session = new Session phpsessid
        expect(session.sessionId).to.equal phpsessid

