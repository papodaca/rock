define [
  "backbone",
  "jquery",
  "underscore",
  "Util",
  "views/MainView",
  "views/AttractView",
  "views/SettingsView",
  "views/ApiDocView",
  "views/SongCollectionView",
  "views/AlbumCollectionView",
  "views/AlbumDetailView"
], (
  Backbone,
  $,
  _,
  Util,
  MainView,
  AttractView,
  SettingsView,
  ApiDocView,
  SongsView,
  AlbumsView,
  AlbumDetailView
) ->
  Backbone.Router.extend
    view: new MainView()
    views: {}
    routes:
      "": "base"
      "settings": "settings"
      "api": "api"
      "songs(/page/:page)": "songs"
      "albums(/page/:page)(/:album_id)": "albums"
    initialize: ->
      $("body").append @view.el
      @base()
      Util.testSession (state) =>
        @loginState(state)
    nav: (fragment)->
      @navigate fragment,
        trigger: true
    loginState: (state) ->
      @view.loginState(state)

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
      @view.navigate(aViewName)
      @getView(aViewName).$el.removeClass "hidden" if @getView(aViewName)?

    hide: (aView) ->
      aView.$el.addClass "hidden" if aView?

    base: ->
      @hideAll()
      unless @getView("base")?
        @addView "base", new AttractView()
      @go "base"

    settings: ->
      @hideAll()
      $(".icon-cog.headerLink").addClass "icon-spin"
      unless @getView("settings")?
        @addView "settings", new SettingsView()
      @go "settings"

    api: ->
      @hideAll()
      unless @getView("api")?
        @addView "api", new ApiDocView()
      @go "api"

    songs: (page)->
      @hideAll()
      unless @getView("songs")?
        if page?
          page= parseInt page
        else
          page= 1
        @addView "songs", new SongsView
          page: page
      else
        if page?
          page = parseInt page
        else
          page = 1
        @getView("songs").navigatePage page
      @go "songs"

    albums: (page, album_id)->
      @hideAll()
      if album_id?
        unless @getView("almun")
          @addView "album", new AlbumDetailView()
        @getView("album").naviageAlbum album_id
        @go "album"
      else
        unless @getView("albums")
          if page?
            page = parseInt page
          else
            page= 1
          @addView "albums", new AlbumsView
            page: page
        else
          if page?
            page = parseInt page
          else
            page = 1
          @getView("albums").navigatePage page
        @go "albums"