gulp = require "gulp"
connect = require "gulp-connect"
hb = require "gulp-hb"
clean = require "gulp-clean"
rename = require "gulp-rename"
sass = require "gulp-ruby-sass"
notify  = require "gulp-notify"
run = require "run-sequence"
browserify = require "browserify"
source = require "vinyl-source-stream"

config = {
  sassPath: "./src/sass"
  bowerDir: "./bower_components"
}


gulp.task 'clean', ->
  gulp.src([
    "./build/*"
    "./tmp/*"
  ], {read:false})
  .pipe clean()


gulp.task "templates", ->
  gulp.src("src/templates/*.hbs")
  .pipe(hb({
      data: require "./src/templates/data.coffee"
      partials: "src/templates/partials/*.hbs"
    }))
  .pipe rename (path)->
    path.extname = ".html"
  .pipe gulp.dest("build")


gulp.task "icons", ->
  gulp.src(config.bowerDir + "/font-awesome/fonts/**.*").pipe(gulp.dest("./build/fonts"))

gulp.task "css", ->

  sass(
    config.sassPath + "/style.scss"
    {
      style: "compressed"
      loadPath: [
        "./src/sass"
        config.bowerDir + "/bootstrap-sass/assets/stylesheets"
        config.bowerDir + "/font-awesome/scss"
      ]
    }
  )
  .on "error", sass.logError
  .pipe gulp.dest("./build/css")


gulp.task "coffeify", ->
  gulp.src("./src/coffee/*.coffee")
  .pipe coffeeify()
  .pipe gulp.dest "./tmp/js"

gulp.task "compile-js", ->
  browserify({
    entries: ["./src/coffee/app.coffee"]
    extensions: [".coffee"]
  })
  .transform "coffeeify"
  .transform "debowerify"
  .bundle()
  .pipe(source("app.js"))
  .pipe(gulp.dest("./build/js"))



gulp.task "connect", ->
  connect.server {root: "./build", port: 8101}


gulp.task "build", ->
  run "clean", [
    "templates"
    "icons"
    "css"
    "compile-js"
  ]

gulp.task "watch", ->
  gulp.watch "src/**/*",["build"]

gulp.task "default", ["build", "watch", "connect"]