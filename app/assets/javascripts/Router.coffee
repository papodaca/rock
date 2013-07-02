define ["backbone", "jquery", "underscore", "views/MainView", "views/AttractView", "views/SettingsView", "views/ApiDocView", "views/SongCollectionView", "views/AlbumCollectionView"], (Backbone, $, _, MainView, AttractView, SettingsView, ApiDocView, SongsView, AlbumsView) ->
  Backbone.Router.extend
    view: new MainView()
    views: {}
    routes:
      "": "base"
      "settings": "settings"
      "api": "api"
      "songs(/page/:page)": "songs"
      "albums(/page/:page)": "albums"
    initialize: ->
      $("body").append @view.el
      @base()
    nav: (fragment)->
      @navigate fragment,
        trigger: true

    addView: (name, view) ->
      @views[name] =  view
      @view.addSubView view

    getView: (name) ->
      return @views[name]

    hideAll: ->
      $(".icon-cog").removeClass "icon-spin"
      for name, view of @views
        @hide view

    go: (aViewName)->
      @getView(aViewName).$el.removeClass "hidden" if @getView(aViewName)?

    hide: (aView) ->
      aView.$el.addClass "hidden" if aView?

    base: ->
      @hideAll()
      unless @getView("BaseView")?
        @addView "BaseView", new AttractView()
      @go "BaseView"

    settings: ->
      @hideAll()
      $(".icon-cog.headerLink").addClass "icon-spin"
      unless @getView("SettingsView")?
        @addView "SettingsView", new SettingsView()
      @go "SettingsView"

    api: ->
      @hideAll()
      unless @getView("ApiDocView")?
        @addView "ApiDocView", new ApiDocView()
      @go "ApiDocView"

    songs: (page)->
      @hideAll()
      unless @getView("SongsView")?
        if page?
          page= parseInt page
        else
          page= 1
        @addView "SongsView", new SongsView
          page: page
      else
        if page?
          page = parseInt page
        else
          page = 1
        @getView("SongsView").navigatePage page
      @go "SongsView"

    albums: (page)->
      @hideAll()
      unless @getView("AlbumsView")
        if page?
          page = parseInt page
        else
          page= 1
        @addView "AlbumsView", new AlbumsView
          page: page
      else
        if page?
          page = parseInt page
        else
          page = 1
        @getView("AlbumsView").navigatePage page
      @go "AlbumsView"