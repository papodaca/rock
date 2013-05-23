define ["backbone", "underscore", "views/MainView", "views/AttractView", "views/SettingsView"], (Backbone, _, MainView, AttractView, SettingsView) ->
  Backbone.Router.extend
    view: new MainView()
    routes:
      "": "base"
      "settings": "settings"
    initialize: ->
      $("body").append @view.el
      @base()
    nav: (fragment)->
      @navigate fragment,
        trigger: true

    base: ->
      @view.setSocket new AttractView()
    settings: ->
      @view.setSocket new SettingsView()
