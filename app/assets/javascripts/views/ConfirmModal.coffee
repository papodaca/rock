define [
  "backbone",
  "underscore",
  "notifier", 
  "hbs!template/ConfirmModal",
  "jquery",
  "jquery.bootstrap"
], (
  Backbone, 
  _, 
  Notifier, 
  Template, 
  LibraryModel, 
  Util, 
  $, 
  BS
) ->
  Backbone.View.extend
    template: Template
    className: "modal hide fade"
    id: "confimModal"
    callback: null
    message: null
    attributes:
      "data-backdrop": "static"
      tabindex: "-1"
      role: "dialog"

    events:
      "click .modal-footer button.btn-success": "yes"
      "click .modal-footer button.btn-info": "no"
      "click .modal-header button": "hide"

    initialize: (options) ->
      @callback = options.callback
      @message = options.message
      @render()

    yes: ->
      @hide()
      @callback? true

    no: ->
      @hide()
      @callback? false

    hide: ->
      @$el.modal "hide"

    render: ->
      @$el.append @template
        message: @message