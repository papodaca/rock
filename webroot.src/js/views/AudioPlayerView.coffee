define ["backbone", "underscore", "jquery", "hbs!template/AudioPlayerView"], (Backbone, _, $, Template) ->
  Backbone.View.extend
    template: Template
    audioPlayer: null
    events:
      "click #volumeButton": "volumeButtonClick"
      "click #muteButton": "muteButtonClick"
      "click #volumeSlider #slider": "volumeSliderClick"
      "click #playPauseButton": "playPauseButtonClick"
      "mousemove #volumeSlider #slider": "volumeSliderMouseMove"
      "mouseout #volumeSlider #slider": "volumeSliderMouseOut"
      "click #playbackBar div.progress": "playbackBarClick"

    initialize: ->
      @render()
      @animLoop _.bind(@thisLoop, this), 250
      @audioPlayer = @$("#audioPlayer").get(0)

    render: ->
      @$el.append @template()
      @volumePopoverLocation true

    calculatePercentage: (x, width) ->
      (x / width) * 100

    secondsToMinutes: (seconds) ->
      minutes = Math.floor(seconds / 60)
      hours = 0
      result = ""
      if minutes > 60
        hours = Math.floor(minutes / 60)
        minutes = Math.floor(minutes % 60)
        result += hours + ":"
        result += "0"  if minutes < 10
      seconds = Math.floor(seconds % 60)
      result += minutes + ":"
      result += "0"  if seconds < 10
      result += seconds
      result

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
          @audioPlayerpause()
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

    thisLoop: (deltaT) ->
      try
        unless $("#bottomNavBar").hasClass("hidden")
          @resize()
          if @audioPlayer.src isnt ""
            playStatus = @secondsToMinutes(@audioPlayer.currentTime) + " / "
            playStatus += @secondsToMinutes(@audioPlayer.duration)
            percent = @calculatePercentage(@audioPlayercurrentTime, @audioPlayer.duration)
            percent_buffered = @calculatePercentage(@audioPlayer.buffered.end(0) - @audioPlayer.currentTime, @audioPlayer.duration)
            @$("#playProgress a.brand").html playStatus
            @$("#playbackBar div.progress div.bar").css "width", percent + "%"
            @$("#playbackBar div.progress div.bar-info").css "width", percent_buffered + "%"
      catch e
        return true
      true

    animLoop: (render, time) ->
      running = undefined
      lastFrame = new Date()
      raf = window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame or window.oRequestAnimationFrame
      loop_ = (now) ->
        
        # stop the loop if render returned false
        if running isnt false
          raf loop_, null
          deltaT = now - lastFrame
          if deltaT > time
            running = render(deltaT)
            lastFrame = now

      loop_ lastFrame
