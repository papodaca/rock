define ["backbone", "underscore", "views/MainView", "views/AttractView", "views/SettingsView"], (Backbone, _, MainView, AttractView, SettingsView) ->
  Backbone.Router.extend
    view: new MainView()
    settingsView: null
    baseView: null
    routes:
      "": "base"
      "settings": "settings"
    initialize: ->
      $("body").append @view.el
      @base()
    nav: (fragment)->
      @clean()
      @navigate fragment,
        trigger: true

    clean: ->
      @goAway @baseView
      @goAway @settingsView

    go: (aView)->
      aView.$el.removeClass "hidden" if aView?

    goAway: (aView) ->
      aView.$el.addClass "hidden" if aView?

    base: ->
      @clean()
      unless @baseView?
        @baseView = new AttractView()
        @view.addSubView @baseView
      @go @baseView

    settings: ->
      @clean()
      unless @settingsView?
        @settingsView = new SettingsView()
        @view.addSubView @settingsView
      @go @settingsView
