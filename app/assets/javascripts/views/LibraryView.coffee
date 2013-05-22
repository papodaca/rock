define ["backbone", "jquery", "hbs!template/LibraryView"], (Backbone, $, Template) ->
  Backbone.View.extend
    tagName: 'tr'
    template: Template
    model: null
    events:
      "click #deleteButton": "deleteLibrary"
      "click #modifyButton": "modifyLibrary"
    initialize: (options)->
      @model = options.model
      @render()

    render: ->
      @$el.empty()
      @$el.append @template @model.attributes

    deleteLibrary: ->
      model.destroy()
      @$el.addClass "hidden"

    modifyLibrary: ->
