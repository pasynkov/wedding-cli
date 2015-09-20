window.$ = window.jQuery = $ = require "jquery"
holder = require "holderjs"
bootstrap = require "bootstrap"
$(document).ready ->
  $("[data-toggle=popover]").popover()
