define [
  "backbone",
  "jquery",
  "hbs!template/AttractView"
], (
  Backbone,
  $,
  Template
) ->
  Backbone.View.extend
    template: Template
    className: "container-fluid"
    initialize: ->
      @render()

    render: ->
      @$el.append @template()
