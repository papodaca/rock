define ["backbone", "jquery", "underscore", "views/MainView", "views/AttractView", "views/SettingsView", "views/ApiDocView"], (Backbone, $, _, MainView, AttractView, SettingsView, ApiDocView) ->
  Backbone.Router.extend
    view: new MainView()
    settingsView: null
    baseView: null
    apiDocView: null
    routes:
      "": "base"
      "settings": "settings"
      "api": "api"
    initialize: ->
      $("body").append @view.el
      @base()
    nav: (fragment)->
      @navigate fragment,
        trigger: true

    hideAll: ->
      $(".icon-cog").removeClass "icon-spin"
      @hide @baseView
      @hide @settingsView
      @hide @apiDocView

    go: (aView)->
      aView.$el.removeClass "hidden" if aView?

    hide: (aView) ->
      aView.$el.addClass "hidden" if aView?

    base: ->
      @hideAll()
      unless @baseView?
        @baseView = new AttractView()
        @view.addSubView @baseView
      @go @baseView

    settings: ->
      @hideAll()
      $(".icon-cog.headerLink").addClass "icon-spin"
      unless @settingsView?
        @settingsView = new SettingsView()
        @view.addSubView @settingsView
      @go @settingsView

    api: ->
      @hideAll()
      unless @apiDocView?
        @apiDocView = new ApiDocView()
        @view.addSubView @apiDocView
      @go @apiDocView

