define ["backbone", "jquery", "Util", "hbs!template/AlbumView"], (Backbone, $, Util, Template) ->
  Backbone.View.extend
    template: Template
    tagName: "div"
    className: "pin"
    model: null
    events:
      "click .btn-success": "enQueue"
      "click .btn-info": "enQueue"
      "click a": "detail"

    initialize: (options) ->
      @model = options.model
      @model.attributes.length = Util.secondsToMinutes(@model.attributes.length)
      @render()

    render: ->
      @$el.append @template @model.attributes

    enQueue: ->
      console.log "enQueue: #{@model.attributes.name}"

    detail: (event) ->
      event.preventDefault()
      console.log "detail: #{@model.attributes.name}"
