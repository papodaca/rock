define [
  "backbone",
  "jquery",
  "Util",
  "models/AlbumModel",
  "models/SongModel"
  "hbs!template/AlbumDetailView"
], (
  Backbone,
  $,
  Util,
  AlbumModel,
  SongModel,
  Template
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    className: "container row"
    model: null
    events:
      "click button.play": "enQueue"
      "click button.add": "enQueue"
      "click a.play": "enQueueSong"
      "click a.add": "enQueueSong"

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
          @render()

    enQueue: (event) ->
      event.preventDefault()
      console.log "enQueue: #{@model.attributes.title}"
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()
      window.audioPlayer.enqueue @model.attributes.songs

    enQueueSong: (event) ->
      event.preventDefault()
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()

      albumId = $(event.target).parents("tr").data("track")
      album = null
      i=0

      while album != null
        if @model.attributes.songs[i].id == albumId
          album = @model.attributes.songs[i]
        i += 1

      console.log "enQueue: #{album.title}"
      window.audioPlayer.enqueue album
