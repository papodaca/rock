define [
  "backbone",
  "jquery",
  "Util",
  "hbs!template/AlbumView"
], (
  Backbone,
  $,
  Util,
  Template
) ->
  Backbone.View.extend
    template: Template
    basePath: Util.basePath
    tagName: "div"
    className: "pin"
    model: null
    events:
      "click .btn-success": "enQueue"
      "click .btn-info": "enQueue"
      "click a": "detail"

    initialize: (options) ->
      @model = options.model
      @render()

    render: ->
      @model.attributes.basePath = @basePath
      @$el.append @template @model.attributes

    enQueue: ->
      console.log "enQueue: #{@model.attributes.name}"

    detail: (event) ->
      event.preventDefault()
      window.Router.nav "#{@basePath}albums/#{@model.attributes.id}"
