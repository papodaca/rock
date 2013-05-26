define ["backbone", "jquery", "underscore", "Util", "views/LibraryModal", "views/ConfirmModal", "hbs!template/LibraryView"], (Backbone, $, _, Util, LibraryModal, ConfirmModal, Template) ->
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
      Util.presentModal new ConfirmModal
        message: "Are you sure you want to delete this Library: " + @model.attributes.name
        callback: _.bind @handleDelete, @


    handleDelete: (answer) ->
      if answer
        @model.destroy()
        @remove()

    modifyLibrary: ->
      Util.presentModal new LibraryModal
        model: @model
        callback: _.bind @updateLibrary, @

    updateLibrary: (model) ->
      @model = model
      @render()
