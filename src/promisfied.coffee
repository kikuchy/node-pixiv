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

    searchWorks: (session, mode, order, pageNo, keyword) ->
        return new Promise (resolve, reject) ->
            pixiv.searchWorks session, mode, order, pageNo, keyword, (error, works) ->
                if error
                    reject error
                resolve works

module.exports = prmPixiv
