define [
  "backbone",
  "jquery",
  "lib/Util",
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
      console.log "enQueue: #{@model.attributes.name}"
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()
      window.audioPlayer.enqueue @model.attributes.songs

    enQueueSong: (event) ->
      event.preventDefault()
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()

      songId = $(event.target).parents("tr").data("track")
      song = null
      i=0

      while song is null
        if @model.attributes.songs[i].id == songId
          song = @model.attributes.songs[i]
        i += 1
      if song?
        console.log "enQueue: #{song.title}"
        window.audioPlayer.enqueue song
