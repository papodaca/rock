define ["backbone", "jquery", "hbs!template/LibraryView"], (Backbone, $, Template) ->
  Backbone.View.extend
    tagName: 'tr'
    template: Template
    model: null
    events:
      "click .btn-danger": "deleteLibrary"
      "click .btn-primary": "modifyLibrary"
    initialize: (options)->
      @model = options.model
      @render()
      @el

    render: ->
      @$el.empty()
      @$el.append @template @model.attributes

    deleteLibrary: ->
      @model.destroy()
      @remove()

    modifyLibrary: ->
