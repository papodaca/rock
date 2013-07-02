define [
  "backbone",
  "jquery",
  "hbs!template/UserView"
], (
  Backbone,
  $,
  Template
) ->
  Backbone.View.extend
    template: Template
    className: "container"
    initialize: ->
      @render()

    render: ->
      @$el.empty().append @template()