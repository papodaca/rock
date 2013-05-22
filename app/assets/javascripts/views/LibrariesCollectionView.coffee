define ["backbone", "jquery", "underscore", "models/LibraryCollectionModel", "views/LibraryView", "hbs!template/LibrariesCollectionView"], (Backbone, $, _, LibraryCollectionModel, LibraryView, Template) ->
  Backbone.View.extend
    template: Template
    id: "libraries"
    className: "container"
    libraries: new LibraryCollectionModel()
    subViews : new Array()
    initialize: ->
      @libraries.on 'reset', @render, this
      @libraries.on 'add', @render, this
      @libraries.fetch()

    render: ->
      if @subViews.length <= 0
        @libraries.each (library) =>
          @subViews.push new LibraryView
            model: library
      @$el.empty().append @template
        objects: @subViews