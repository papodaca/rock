define [
  "jquery",
  "jquery.bootstrap"
], (
  $,
  BS
)->
  sessionKey: "session_key"
  contains: (s, subS) ->
    s.indexOf(subS) isnt -1
  presentModal: (modal) ->
    $("#modalSocket").empty().append modal.el
    modal.$el.modal "show"
  setSession: (value) ->
    @setPerminateCookie @sessionKey, value
  destroySession: ->
    @removeCookie @sessionKey
  setPerminateCookie: (key, value) ->
    date = new Date()
    date.setFullYear date.getFullYear() + 20
    document.cookie = key + "=" + value + ";expires=" + date.toGMTString() + ";path=/"
  removeCookie: (key) ->
    document.cookie = key + "=;expires=Thu, 01 Jan 1970 00:00:01 GMT";
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
