define [
  "backbone",
  "underscore",
  "jquery",
  "lib/Queue",
  "Util",
  "hbs!template/AudioPlayerView"
], (
  Backbone,
  _,
  $,
  Queue,
  Util,
  Template
) ->
  Backbone.View.extend
    template: Template
    audioPlayer: null
    playing: false
    queue: new Queue()
    currentSong: null
    events:
      "click #volumeButton": "volumeButtonClick"
      "click #muteButton": "muteButtonClick"
      "click #volumeSlider #slider": "volumeSliderClick"
      "click #playPauseButton": "playPauseButtonClick"
      "mousemove #volumeSlider #slider": "volumeSliderMouseMove"
      "mouseout #volumeSlider #slider": "volumeSliderMouseOut"
      "click #playbackBar div.progress": "playbackBarClick"
      "click #forwardButton": "nextSong"
      "click #backButton": "previousSong"

    initialize: ->
      @render()
      window.setTimeout _.bind(@thisLoop, @), 250
      @audioPlayer = @$("#audioPlayer").get(0)

    enqueue: (value) ->
      if value.push? #this is an array
        _.each value, (song) =>
          @queue.enqueue song
      else
        @queue.enqueue value

    emptyQueue: () ->
      @playing = false
      @audioPlayer.src = ""
      @currentSong = null
      @$("#playProgress a.brand").html ""
      @$("#playbackBar div.progress div.bar").css "width", 0 + "%"
      @$("#playbackBar div.progress div.bar-info").css "width", 0 + "%"
      @queue.empty()

    render: ->
      @$el.append @template()
      @volumePopoverLocation true

    calculatePercentage: (x, width) ->
      (x / width) * 100

    volumePopoverVisible: false
    volumeButtonClick: (event) ->
      @volumePopoverLocation()
      unless @volumePopoverVisible
        @$("#volumePopover").css "display", "block"
        _.delay (->
          @$("#volumePopover").removeClass "out"
          @$("#volumePopover").addClass "in"
        ), 5, this
        @volumePopoverVisible = true
      else
        @$("#volumePopover").removeClass "in"
        @$("#volumePopover").addClass "out"
        _.delay (->
          @$("#volumePopover").css "display", "none"
        ), 250, this
        @volumePopoverVisible = false

    volumePopoverLocation: (force) ->
      button = @$("#volumeButton")
      popover = @$("#volumePopover .popover-content")
      p = button.offset()
      if @$("#volumePopover").css("display") isnt "none" or force
        p.left = p.left - (popover.outerWidth(true) / 2) + (button.outerWidth() / 2)
        p.top = p.top - (popover.outerHeight(true) / 2) - (button.outerHeight() / 2)
        @$("#volumePopover").css "top", p.top + "px"
        @$("#volumePopover").css "left", p.left - 30 + "px"

    muteButtonClick: (event) ->
      @$(event.currentTarget).toggleClass "btn-danger"
      if @audioPlayer.muted
        @audioPlayer.muted = false
      else
        @audioPlayer.muted = true

    playPauseButtonClick: (event) ->
      if @audioPlayer.src isnt ""
        if @audioPlayer.paused is false
          @audioPlayer.pause()
        else
          @audioPlayer.play()
        @$("#playPauseButton i").toggleClass "icon-play"
        @$("#playPauseButton i").toggleClass "icon-pause"

    volumeSliderClick: (event) ->
      percent = @calculatePercentage(event.offsetX, event.currentTarget.clientWidth)
      @$("#volumeSlider #slider div.bar").css "width", percent + "%"
      @$("#volumeSlider #echo").html Math.ceil(percent) + "%"
      @audioPlayer.volume = percent / 100

    volumeSliderMouseMove: (event) ->
      percent = @calculatePercentage(event.offsetX, event.currentTarget.clientWidth)
      @$("#volumeSlider #echo").html Math.ceil(percent) + "%"

    volumeSliderMouseOut: (event) ->
      width = @$("#volumeSlider #slider div.bar").css("width").replace("px", "")
      percent = @calculatePercentage(width, event.currentTarget.clientWidth)
      @$("#volumeSlider #echo").html Math.ceil(percent) + "%"

    playbackBarClick: (event) ->
      if @audioPlayer.seekable and @audioPlayer.seekable.length > 0
        percent = @calculatePercentage(event.offsetX, event.currentTarget.clientWidth)
        @$("#playbackBar div.progress div.bar").css "width", percent + "%"
        @audioPlayer.currentTime = @audioPlayer.duration * (percent / 100)

    resize: ->
      @volumePopoverLocation()
      if @audioPlayer.src is ""
        @$("#playProgress").addClass "hidden"
        @$("#playbackBar").addClass "hidden"
      else
        newPlaybackWidth = @$("#playProgress").offset().left - 15 - (@$("#plabackControls").offset().left + @$("#plabackControls").outerWidth(true))
        width = @$("#playbackBar").css("width")
        regex = /[^0-9]/g
        @$("#playbackBar").css "width", newPlaybackWidth + "px"  if regex.exec(width)[0] isnt newPlaybackWidth
        @$("#playProgress").removeClass "hidden"
        @$("#playbackBar").removeClass "hidden"

    loginState: (state) ->
      if state
        @$("#bottomNavBar").removeClass "hidden"
      else
        @$("#bottomNavBar").addClass "hidden"

    nextSong: () ->
      @currentSong = @queue.next()
      @play()
      @setPlaying()

    previousSong: () ->
      if @queue.middle()
        @currentSong = @queue.previous()
        @play()
        @setPlaying()

    play: () ->
      @audioPlayer.src = "#{Util.basePath}api/songs/#{@currentSong.id}/stream"
      console.log "Playing: #{@currentSong.title}"
      @audioPlayer.play()

    setPlaying: () ->
      if @$("#playPauseButton i").hasClass "icon-play"
        @$("#playPauseButton i").removeClass "icon-play"
        @$("#playPauseButton i").addClass "icon-pause"

    thisLoop: (deltaT) ->
      window.setTimeout _.bind(@thisLoop, @), 250
      try
        unless $("#bottomNavBar").hasClass("hidden")
          if @playing is false and @queue.length > 0
            @playing = true
            unless @currentSong?
              @currentSong = @queue.current()
            @play()
            @setPlaying()
            @audioPlayer.play()
          if @calculatePercentage(@audioPlayer.currentTime, @audioPlayer.duration) is 100
            @nextSong()
          if @audioPlayer.src isnt ""
            playStatus = Util.secondsToMinutes(@audioPlayer.currentTime) + " / "
            playStatus += Util.secondsToMinutes(@audioPlayer.duration)
            percent = @calculatePercentage(@audioPlayer.currentTime, @audioPlayer.duration)
            percent_buffered = @calculatePercentage(@audioPlayer.buffered.end(0) - @audioPlayer.currentTime, @audioPlayer.duration)
            @$("#playProgress a.brand").html playStatus
            @$("#playbackBar div.progress div.bar").css "width", percent + "%"
            @$("#playbackBar div.progress div.bar-info").css "width", percent_buffered + "%"
          @resize()
      catch
