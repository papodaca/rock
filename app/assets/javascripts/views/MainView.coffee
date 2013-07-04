define [
  "backbone",
  "jquery",
  "views/HeaderView",
  "views/AudioPlayerView",
  "hbs!template/MainView"
], (
  Backbone,
  $,
  HeaderView,
  AudioPlayerView,
  Template
) ->
  Backbone.View.extend
    
    #el: $('body'),
    template: Template
    header: null
    audioPlayer: null
    initialize: ->
      @header = new HeaderView()
      @audioPlayer = new AudioPlayerView()
      @render()
      $(window).bind "resize.app", _.bind(@resize, this)

    render: ->
      @$el.append @header.el
      @$el.append @template()
      @$el.append @audioPlayer.el

    resize: ->
      @audioPlayer.resize @audioPlayer

    remove: ->
      $(window).unbind "resize.app"
      Backbone.View::remove.call this

    addSubView: (aView) ->
      @$("#socket").append aView.el

    navigate: (name) ->
      @header?.navigate name

    loginState: (state) ->
      @header.loginState(state)
      @audioPlayer.loginState(state)
