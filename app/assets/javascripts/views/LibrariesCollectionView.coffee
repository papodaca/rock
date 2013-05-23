define ["backbone", "jquery", "jquery.bootstrap", "underscore", "models/LibraryCollectionModel", "models/LibraryModel", "views/LibraryView", "hbs!template/LibrariesCollectionView"], (Backbone, $, BS, _, LibraryCollectionModel, LibraryModal, LibraryView, Template) ->
  Backbone.View.extend
    template: Template
    id: "libraries"
    className: "container"
    libraries: new LibraryCollectionModel()
    events:
      "click #newLibraryButton" : "newLibrary"
      "click .modal-header button": "hideModal"
      "click .modal-footer button.btn-primary": "submitNewLibrary"
    initialize: ->
      @libraries.on 'add', @addLibrary, this
      @render()
      @libraries.fetch()

    render: ->
      @$el.empty().append @template()

    addLibrary: (library) ->
      libraryView = new LibraryView
        model: library
      @$("table tbody").append libraryView.el

    newLibrary: ->
      $("#newLibraryModal").modal "show"

    hideModal: ->
      $("#newLibraryModal").modal "hide"
      @$(".modal input").val ""

    saveSuccess: (model, msg) ->
      @libraries.add model
      @hideModal()

    saveError: (model, error) ->
      console.log error

    submitNewLibrary: ->
      model = new LibraryModal()
      model.set
        name: @$(".name input").val()
        path: @$(".path input").val()
      model.save {},
        success: _.bind(@saveSuccess, this)
        error: _.bind(@saveError, this)
