define ["backbone", "jquery", "underscore", "Util", "views/LibraryModal", "hbs!template/LibraryView"], (Backbone, $, _, Util, LibraryModal, Template) ->
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
      modal = new LibraryModal
        model: @model
        callback: _.bind @updateLibrary, this
      Util.presentModal modal

    updateLibrary: (model) ->
      @model = model
      @render()
