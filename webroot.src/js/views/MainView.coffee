define ["backbone", "jquery", "views/HeaderView", "views/AudioPlayerView", "hbs!template/MainView"], (Backbone, $, HeaderView, AudioPlayerView, Template) ->
  Backbone.View.extend
    
    #el: $('body'),
    template: Template
    header: new HeaderView()
    audioPlayer: new AudioPlayerView()
    socket: null
    initialize: ->
      @render()
      $(window).bind "resize.app", _.bind(@resize, this)

    render: ->
      @$el.append @header.el
      @$el.append @template()
      @$el.append @audioPlayer.el
      @$el.append "<div id=\"notificationContainer\"></div>"

    resize: ->
      @audioPlayer.resize @audioPlayer

    remove: ->
      $(window).unbind "resize.app"
      Backbone.View::remove.call this

    setSocket: (socket) ->
      @socket = socket
      @$("#socket").empty().append @socket.el


