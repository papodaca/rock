define ["backbone", "jquery", "underscore", "Util", "views/LibraryModal", "views/ConfirmModal", "hbs!template/LibraryView"], (Backbone, $, _, Util, LibraryModal, ConfirmModal, Template) ->
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
      Util.animLoop _.bind(@thisLoop, this), 250 if @model.attributes.progress?
      @el

    render: ->
      @$el.empty()
      @$el.append @template @model.attributes

    deleteLibrary: ->
      Util.presentModal new ConfirmModal
        message: "Are you sure you want to delete this Library: " + @model.attributes.name
        callback: _.bind @handleDelete, @

    handleDelete: (answer) ->
      if answer
        @model.destroy()
        @remove()

    modifyLibrary: ->
      Util.presentModal new LibraryModal
        model: @model
        callback: _.bind @updateLibrary, @

    updateLibrary: (model) ->
      @model = model
      @render()

    updateProgress: (model) ->
      if model.attributes.progress?
        @$(".progress").removeClass "hidden"
        @$(".progress .bar").css "width", model.attributes.progress.toString() + "%"

    thisLoop: (deltaT) ->
      try

        unless @model.attributes.progress?
          @$(".progress").addClass "hidden"
          return false
        else
          @model.fetch
            success: _.bind @updateProgress, @
      catch e
        return true
      true
