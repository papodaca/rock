define [
  "backbone",
  "underscore",
  "notifier",
  "hbs!template/LibraryModal",
  "models/LibraryModel",
  "Util",
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
    id: "libraryModal"
    library: null
    callback: null
    attributes:
      "data-backdrop": "static"
      tabindex: "-1"
      role: "dialog"

    events:
      "click .modal-footer button": "submit"
      "click .modal-header button": "hide"

    initialize: (options) ->
      @library = (if options.model? then options.model else new LibraryModel())
      @callback = options.callback
      @render()

    onError: (model, error) ->
      if Util.contains(error, "nameNull")
        @$(".name .label").html("Name required").removeClass "hidden"
        @$(".name").addClass "error"
      if Util.contains(error, "pathNull")
        @$(".path .label").html("Path required").removeClass "hidden"
        @$(".path").addClass "error"
      @$(".modal-footer button").removeClass "disabled"

    submit: ->
      unless @$(".modal-footer button").hasClass("disabled")
        @resetError()
        @$(".modal-footer button").addClass "disabled"
        @library.set
          name: @$(".name input").val()
          path: @$(".path input").val()

        if @library.isValid()
          @library.save {},
            success: _.bind(@saveSuccess, this)
            error: _.bind(@saveError, this)
        else
          @onError @library, @library.validationError

    resetError: ->
      @$(".label").addClass "hidden"
      @$(".control-group").removeClass "error"

    reset: ->
      @$("input").val ""
      @resetError
      @$(".modal-footer button").removeClass "disabled"

    saveSuccess: (model, msg) ->
      @callback? model, null, msg
      @hide()

    saveError: (model, error) ->
      @callback? model, error, error.statusText
      @hide()
      console.log error

    hide: ->
      @reset()
      @$el.modal "hide"

    render: ->
      @$el.append @template
        model: @library
