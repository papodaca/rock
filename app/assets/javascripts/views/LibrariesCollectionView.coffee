define ["backbone", "jquery", "hbs!template/LibrariesCollectionView"], (Backbone, $, Template) ->
  Backbone.View.extend
    template: Template
    id: "libraries"
    className: "container"
    initialize: ->
      @render()

    render: ->
      @$el.empty().append @template()