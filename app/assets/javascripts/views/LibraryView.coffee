define ["backbone", "jquery", "hbs!template/LibraryView"], (Backbone, $, Template) ->
  Backbone.View.extend
    tagName: 'tr'
    template: Template
    model: null
    initialize: (options)->
      @model = options.model
      @render()

    render: ->
      @$el.empty()
      @$el.append @template @model.attributes
