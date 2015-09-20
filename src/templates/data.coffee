
fs = require "fs"
_ = require "underscore"

class TemplateData

  constructor: ->

    items = fs.readdirSync "./src/templates"

    @index =
      title: "List of pages"
      items: _.compact _.map items, (item)->
        [name, ext] = item.split "."
        if not ext or ext isnt "hbs"
          return false
        return name + ".html"

    @young_page =
      title: "Страница свадьбы"
      wedding_menu: @getWeddingMenu "wedding"
      wedding:
        date: new Date("2015-08-23T00:00:00+0400")
      wedding_cards: @getWeddingCards()

  getWeddingMenu: (active)->

    wedding_menu = [
      {
        link: "wedding"
        title: "Свадьба"
      }
      {
        link: "calculator"
        title: "Калькулятор"
      }
      {
        link: "button"
        title: "Кнопка"
      }
      {
        link: "wedding_settings"
        title: "Настройки"
      }
    ]

    _.map(
      wedding_menu
      (item)->
        if item.link is active
          item.active = true
        else
          item.active = false
        item
    )

  getWeddingCards: ->
    cards = [
      {
        name: "Фотограф"
        icon: "camera"
      }
      {
        name: "Место проведения"
        icon: "home"
      }
      {
        name: "Видеооператор"
        icon: "video-camera"
      }
      {
        name: "Водитель"
        icon: "car"
      }
      {
        name: "Декоратор"
        icon: "image"
      }
      {
        name: "ЗАГС"
        icon: "institution"
      }
      {
        name: "Ведущий"
        icon: "group"
      }
      {
        name: "ДиДжей"
        icon: "music"
      }
    ]

    _.map(
      cards
      (card)->
        unless _.random(0, 2)
          card.user = {
            name: "Иванов Иван"
          }
        card.count = _.random(100, 300)
        card
    )



module.exports = TemplateData