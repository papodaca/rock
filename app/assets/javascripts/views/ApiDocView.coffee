define [
  "backbone",
  "jquery",
  "underscore",
  "lib/Util",
  "hbs!template/ApiDocView"
], (
  Backbone,
  $,
  _,
  Util,
  Template
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    id: "api"
    initialize: ->
      @render()
      Util.animLoop(_.bind(@resize,@), 1)

    resize : ->
      unless this.$el.hasClass("hidden")
        height = @$("iframe")?.contents()?[0]?.body?.offsetHeight
        windowHeight = $(window).height() - 90
        if height < windowHeight
          @$('iframe').css "height", "100%"
          @$('iframe').parent().css "height", "#{windowHeight}px"
        else
          @$('iframe').css "height", "#{height + 20}px"
          @$('iframe').parent().css "height", "#{height}px"

    render: ->
      @$el.append @template
        basePath: @basePath
