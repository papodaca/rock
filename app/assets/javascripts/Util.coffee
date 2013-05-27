define ["jquery", "jquery.bootstrap"], ($, BS)->
  contains: (s, subS) ->
    s.indexOf(subS) isnt -1
  presentModal: (modal) ->
    $("#modalSocket").empty().append modal.el
    modal.$el.modal "show"
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
