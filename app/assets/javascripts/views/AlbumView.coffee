define ["backbone", "jquery", "Util", "hbs!template/AlbumView"], (Backbone, $, Util, Template) ->
  Backbone.View.extend
    template: Template
    tagName: "div"
    className: "pin"
    model: null
    events:
      "click a.play": "enQueue"

    initialize: (options) ->
      @model = options.model
      @render()

    render: ->
      @$el.append @template @model.attributes

    enQueue: ->
      console.log "enQueue: #{@model.attributes.name}"
