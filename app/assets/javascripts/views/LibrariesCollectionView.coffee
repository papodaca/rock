define ["backbone", "jquery", "jquery.bootstrap", "underscore", "models/LibraryCollectionModel", "models/LibraryModel", "views/LibraryView", "views/LibraryModal", "Util", "hbs!template/LibrariesCollectionView"], (Backbone, $, BS, _, LibraryCollectionModel, LibraryModel, LibraryView, LibraryModal, Util,Template) ->
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
      modal = new LibraryModal
        callback: _.bind @addLibrary, this
      Util.presentModal modal
