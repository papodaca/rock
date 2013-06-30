define ["backbone", "jquery", "Util", "hbs!template/SongView"], (Backbone, $, Util, Template) ->
  Backbone.View.extend
    template: Template
    tagName: "tr"
    className: ""
    model: null
    events: {}

    initialize: (options) ->
      @model = options.model
      @render()

    render: ->
      @$el.append @template @model.attributes
