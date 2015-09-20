
fs = require "fs"
_ = require "underscore"

class TemplateData

  constructor: ->

    console.log "hello"

    items = fs.readdirSync "./src/templates"


    @index =
      title: "Index"
      items: _.compact _.map items, (item)->
        [name, ext] = item.split "."
        if not ext or ext isnt "hbs"
          return false
        return name + ".html"


module.exports = new TemplateData