define ["backbone", "jquery", "underscore", "views/MainView", "views/AttractView", "views/SettingsView", "views/ApiDocView", "views/SongCollectionView"], (Backbone, $, _, MainView, AttractView, SettingsView, ApiDocView, SongsView) ->
  Backbone.Router.extend
    view: new MainView()
    settingsView: null
    baseView: null
    apiDocView: null
    songsView: null
    routes:
      "": "base"
      "settings": "settings"
      "api": "api"
      "songs(/page/:page)": "songs"
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
      @hide @songsView

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

    songs: (page)->
      @hideAll()
      unless @songsView
        if page?
          @songsView = new SongsView
            page: parseInt page
        else
          @songsView = new SongsView
            page: 1
        @view.addSubView @songsView
      else
        if page?
          @songsView.navigatePage parseInt page
        else
          @songsView.navigatePage 1
      @go @songsView

