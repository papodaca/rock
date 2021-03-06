define [
  "backbone",
  "jquery",
  "lib/Util",
  "hbs!template/AlbumCollectionView",
  "views/AlbumView",
  "models/AlbumCollectionModel"
], (
  Backbone,
  $,
  Util,
  Template,
  AlbumView,
  AlbumCollectionModel
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    id: "albums"
    className: "container"
    albums: null
    events:
      "click .pagination ul li a": "handlePagination"

    initialize: (options) ->
      @albums = new AlbumCollectionModel()
      @albums.on "add", @addAlbum, @
      @albums.on "sync", @setupPagination, @
      @albums.getPage parseInt options.page
      @render()
      @$("div#columns").empty()

    addAlbum: (album) ->
      albumView = new AlbumView
        model: album
      @$("div#columns").append albumView.el

    render: ->
      @$el.append @template()

    setupPagination: ->
      element = @$(".pagination ul").empty()
      element.append @getPageEl @albums.state.currentPage-1, "Previous", "" if @albums.state.currentPage != 1
      i=1
      while i<=@albums.state.totalPages
        if @albums.state.currentPage == i
          element.append @getPageEl i, i, "active"
        else
          element.append @getPageEl i, i, ""
        i += 1
      element.append @getPageEl @albums.state.currentPage+1, "Next", "" unless @albums.state.currentPage == @albums.state.lastPage

    getPageEl: (pageData, page, state) ->
      "<li class=\"#{state}\"><a data-page=\"#{pageData}\" href=\"#{@basePath}albums/page/#{pageData}\">#{page}</a></li>"

    handlePagination: (sender) ->
      sender.preventDefault()
      unless $(sender.target).parent().hasClass("active")
        page = $(sender.target).data "page"
        window.Router.nav "albums/page/" + page

    navigatePage: (page) ->
      unless @albums.state.currentPage == parseInt page
        @$("div#columns").empty()
        @albums.getPage parseInt page
