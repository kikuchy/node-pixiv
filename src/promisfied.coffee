pixiv = require "./pixiv"
Promise = (require "es6-promise").Promise

prmPixiv =
    createSession: (userId, password) ->
        return new Promise (resolve, reject) ->
            pixiv.createSession userId, password, (error, session) ->
                if error
                    reject error
                resolve session

    getGrapichWork: (session, workId) ->
        return new Promise (resolve, reject) ->
            pixiv.getGrapichWork session, workId, (error, work) ->
                if error
                    reject error
                resolve work

module.exports = prmPixiv
