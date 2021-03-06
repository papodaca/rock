define [
  "backbone",
  "underscore",
  "jquery",
  "lib/Queue",
  "lib/Util",
  "hbs!template/AudioPlayerView",
  "hbs!template/QueueItem"
], (
  Backbone,
  _,
  $,
  Queue,
  Util,
  Template,
  QueueItem
) ->
  Backbone.View.extend
    template: Template
    QueueItemTemplate: QueueItem
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
      "click #queueButton": "queueButtonClick"

    initialize: ->
      @render()
      window.setTimeout _.bind(@thisLoop, @), 250
      @audioPlayer = @$("#audioPlayer").get(0)

    enqueue: (value) ->
      if value.push? #this is an array
        _.each value, (song) =>
          @addSong song
      else
        @addSong value

    addSong: (song) ->
      @queue.enqueue song
      content = @QueueItemTemplate song
      @$("#queuePopover .popover-content table tbody").append content
      @queuePopoverLocation true

    emptyQueue: () ->
      @playing = false
      @audioPlayer.src = ""
      @currentSong = null
      @$("#playProgress a.brand").html ""
      @$("#playbackBar div.progress div.bar").css "width", 0 + "%"
      @$("#playbackBar div.progress div.bar-info").css "width", 0 + "%"
      @$("#queuePopover .popover-content table tbody").empty()
      @queue.empty()

    render: ->
      @$el.append @template()
      @volumePopoverLocation true

    calculatePercentage: (x, width) ->
      (x / width) * 100

    queuePopoverVisible: false
    queueButtonClick: (event) ->
      @queuePopoverLocation()
      unless @queuePopoverVisible
        @$("#queuePopover").css "display", "block"
        _.delay (->
          @$("#queuePopover").removeClass "out"
          @$("#queuePopover").addClass "in"
        ), 5, this
        @queuePopoverVisible = true
      else
        @$("#queuePopover").removeClass "in"
        @$("#queuePopover").addClass "out"
        _.delay (->
          @$("#queuePopover").css "display", "none"
        ), 250, this
        @queuePopoverVisible = false

    queuePopoverLocation: (force) ->
      @popoverLocation force, @$("#queueButton"), @$("#queuePopover")

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
      @popoverLocation force, @$("#volumeButton"), @$("#volumePopover")

    popoverLocation: (force, button, popover) ->
      if popover.css("display") isnt "none" or force
        innerPopover = $(popover).children(".popover-content")
        p = button.offset()
        p.left = p.left - (innerPopover.outerWidth(true) / 2) + (button.outerWidth() / 2) - 23
        p.top = p.top - (innerPopover.outerHeight(true) - 15) - (button.outerHeight() / 2)
        popover.css "top", p.top + "px"
        popover.css "left", p.left + "px"

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
      @queuePopoverLocation()
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
      next = @queue.peek()
      if next isnt @currentSong
        @currentSong = @queue.next()
        @play()
        @setPlaying()

    previousSong: () ->
      previous = @queue.peekBack()
      if @queue.middle() and previous isnt @currentSong
        @currentSong = @queue.previous()
        @play()
        @setPlaying()

    play: () ->
      @$("#queuePopover .popover-content table tbody").children().removeClass("info")
      $(@$("#queuePopover .popover-content table tbody").children().get(@queue.ptr)).addClass("info")
      @audioPlayer.src = "#{Util.basePath}api/songs/#{@currentSong.id}/stream"
      console.log "Playing: #{@currentSong.title}"
      @audioPlayer.play()

    setPlaying: () ->
      if @$("#playPauseButton i").hasClass "icon-play"
        @$("#playPauseButton i").removeClass "icon-play"
        @$("#playPauseButton i").addClass "icon-pause"

    thisLoop: (deltaT) ->
      try
        window.setTimeout _.bind(@thisLoop, @), 250
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
