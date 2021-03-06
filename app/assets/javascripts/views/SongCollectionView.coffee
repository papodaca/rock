define [
  "backbone",
  "jquery",
  "lib/Util",
  "hbs!template/SongCollectionView",
  "views/SongView",
  "models/SongCollectionModel"
], (
  Backbone,
  $,
  Util,
  Template,
  SongView,
  SongsCollectionModel
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    id: "songs"
    className: "container row"
    songs: null
    events:
      "click .pagination ul li a": "handlePagination"

    initialize: (options) ->
      @songs = new SongsCollectionModel()
      @songs.on "add", @addSong, @
      @songs.on "sync", @setupPagination, @
      @songs.getPage parseInt options.page
      @render()
      @$(".pagination ul").empty()

    addSong: (song) ->
      songView = new SongView
        model: song
      @$("table tbody").append songView.el

    render: ->
      @$el.append @template()

    setupPagination: ->
      element = @$(".pagination ul").empty()
      element.append @getPageEl @songs.state.currentPage-1, "Previous", "" if @songs.state.currentPage != 1
      i=1
      while i<=@songs.state.totalPages
        if @songs.state.currentPage == i
          element.append @getPageEl i, i, "active"
        else
          element.append @getPageEl i, i, ""
        i += 1
      element.append @getPageEl @songs.state.currentPage+1, "Next", "" unless @songs.state.currentPage == @songs.state.lastPage

    getPageEl: (pageData, page, state) ->
      "<li class=\"#{state}\"><a data-page=\"#{pageData}\" href=\"#{@basePath}songs/page/#{pageData}\">#{page}</a></li>"

    handlePagination: (event) ->
      event.preventDefault()
      unless $(event.target).parent().hasClass("active")
        page = $(event.target).data "page"
        window.Router.nav "songs/page/" + page

    navigatePage: (page) ->
      unless @songs.state.currentPage == parseInt page
        @$("table tbody").empty()
        @songs.getPage parseInt page
