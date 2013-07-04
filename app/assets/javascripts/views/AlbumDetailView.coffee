define [
  "backbone",
  "jquery",
  "Util",
  "models/AlbumModel",
  "hbs!template/AlbumDetailView"
], (
  Backbone,
  $,
  Util,
  AlbumModel
  Template
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    className: "container row"
    model: null
    events:
      "click .btn-success": "enQueue"
      "click .btn-info": "enQueue"
      "click .play": "enQueue"

    initialize: (options) ->
      #@render()

    render: ->
      @$el.empty().append Template @model.attributes

    naviageAlbum: (album_id) ->
      @model = new AlbumModel
        id: album_id
      @model.fetch
        success: (model) =>
          @model = model
          song.length = Util.secondsToMinutes song.length for song in @model.attributes.songs
          @model.attributes.length = Util.secondsToMinutes @model.attributes.length
          @render()
