CSV = require "comma-separated-values"

class Work
    constructor: (@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly)->
        @entryDate  = if entryDate instanceof Date then entryDate else new Date(entryDate)
        @tags       = if tags instanceof Array then tags else tags.split " "

    @parseSingle: (rawCSV) ->
        c = new CSV rawCSV
        l = c.parse()[0]
        if l[19] > 0
            new MangaWork l[0], l[3], l[12], l[13], l[15], l[16], l[17], l[18], l[22], l[23], l[26], l[4], l[6], l[9], l[19]
        else
            new IllustWork l[0], l[3], l[12], l[13], l[15], l[16], l[17], l[18], l[22], l[23], l[26], l[4], l[6], l[9]

class GraphicWork extends Work
    constructor: (@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly, @serverNumber, @smallThumbnail, @middleThumbnail)->
        super(@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly)

class IllustWork extends GraphicWork
    constructor: (@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly, @serverNumber, @smallThumbnail, @middleThumbnail)->
        super(@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly, @serverNumber, @smallThumbnail, @middleThumbnail)

class MangaWork extends GraphicWork
    constructor: (@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly, @serverNumber, @smallThumbnail, @middleThumbnail, @pageCount)->
        super(@workId, @title, entryDate, tags, @evaluateCount, @evaluateSum, @viewCount, @caption, @bookmarkCount, @commentCount, @isAdultOnly, @serverNumber, @smallThumbnail, @middleThumbnail)

class AnimationWork extends GraphicWork

class NovelWork extends Work

module.exports = {
    Work
    GraphicWork
    IllustWork
    MangaWork
    AnimationWork
    NovelWork
}
