define [
  "backbone",
  "jquery",
  "lib/Util",
  "hbs!template/SongView"
], (
  Backbone,
  $,
  Util,
  Template
) ->
  Backbone.View.extend
    template: Template
    tagName: "tr"
    className: ""
    model: null
    events:
      "click a.play": "enQueue"
      "click a.add": "enQueue"

    initialize: (options) ->
      @model = options.model
      @render()

    render: ->
      @$el.append @template @model.attributes

    enQueue: (event) ->
      event.preventDefault()
      console.log "enQueue: #{@model.attributes.title}"
      if $(event.target).parent().hasClass("play") or $(event.target).hasClass("play")
        window.audioPlayer.emptyQueue()
      window.audioPlayer.enqueue @model.attributes
