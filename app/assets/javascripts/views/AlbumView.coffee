define [
  "backbone",
  "jquery",
  "lib/Util",
  "models/AlbumModel"
  "hbs!template/AlbumView"
], (
  Backbone,
  $,
  Util,
  AlbumModel,
  Template
) ->
  Backbone.View.extend
    template: Template
    tagName: "div"
    className: "pin"
    model: null
    events:
      "click button.play": "enQueue"
      "click button.add": "enQueue"
      "click a": "detail"

    initialize: (options) ->
      @model = options.model
      @render()

    render: ->
      @model.attributes.basePath = @basePath
      @$el.append @template @model.attributes

    enQueue: (event) ->
      event.preventDefault()
      console.log "enQueue: #{@model.attributes.name}"
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()
      @model = new AlbumModel
        id: @model.attributes.id
      @model.fetch
        success: (msg) =>
          window.audioPlayer.enqueue @model.attributes.songs

    detail: (event) ->
      event.preventDefault()
      window.Router.nav "#{Util.basePath}albums/#{@model.attributes.id}"
