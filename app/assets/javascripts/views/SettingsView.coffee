define ["backbone", "jquery", "views/LibrariesCollectionView", "hbs!template/SettingsView"], (Backbone, $, LibrariesCollectionView, Template) ->
  Backbone.View.extend
    template: Template
    libraries: new LibrariesCollectionView()
    initialize: ->
      @render()

    render: ->
      @$el.empty().append @template()
      @$("#settings").empty().append @libraries.el