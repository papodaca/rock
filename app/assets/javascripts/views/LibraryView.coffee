define ["backbone", "jquery", "underscore", "Util", "views/LibraryModal", "views/ConfirmModal", "hbs!template/LibraryView"], (Backbone, $, _, Util, LibraryModal, ConfirmModal, Template) ->
  Backbone.View.extend
    tagName: 'tr'
    template: Template
    model: null
    events:
      "click .buttonDelete": "deleteLibrary"
      "click .buttonModify": "modifyLibrary"
      "click .buttonScan": "scanLibrary"
    initialize: (options)->
      @model = options.model
      @render()
      @startScanPolling()
      @el

    startScanPolling: (model) ->
      @model.attributes.progress = model.progress if model?
      Util.animLoop _.bind(@thisLoop, this), 250 if @model.attributes.progress?

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

    scanLibrary: ->
      @model.scan
        success: _.bind @startScanPolling, @

    updateLibrary: (model) ->
      @model = model
      @render()

    updateProgress: (model) ->
      if model.attributes.progress?
        @$(".songCount").empty().append model.attributes.songs
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
