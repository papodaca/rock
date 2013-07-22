define [
  "jquery",
  "jquery.bootstrap",
  "handlebars",
  "BasePath"
], (
  $,
  BS,
  Handlebars,
  BasePath
)->
  class Util
    @sessionKey: "_Rock_session_key"
    @basePath: BasePath
    @contains: (s, subS) ->
      s.indexOf(subS) isnt -1
    @presentModal: (modal) ->
      $("#modalSocket").empty().append modal.el
      modal.$el.modal "show"
    @login: (username, password, callback) ->
      $.ajax
        url: "#{@basePath}api/sessions"
        contentType: "application/json"
        data: JSON.stringify
          email: username
          password: password
        type: "POST"
        success: (msg) =>
          @setSession msg.session_key
          callback true
        error: (msg) ->
          callback false
    @testSession: (callback) ->
      $.ajax
        url: "#{@basePath}api/sessions/test"
        contentType: "application/json"
        type: "GET"
        success: (msg) ->
          callback msg == "OK"
        error: (msg) ->
          callback false
    @setSession: (key) ->
      @setPerminateCookie @sessionKey, key
    @destroySession: ->
      $.ajax
        url: "#{@basePath}api/sessions"
        contentType: "application/json"
        data: JSON.stringify
          session_key: @getCookie @session_key
        type: "DELETE"
      #@removeCookie @sessionKey
    @setPerminateCookie: (key, value) ->
      date = new Date()
      date.setFullYear date.getFullYear() + 20
      document.cookie = key + "=" + value + ";expires=" + date.toGMTString() + ";path=/"
    @getCookie: (name) ->
      allCookies = document.cookie.split(";")
      cookieFound = false # set boolean t/f default f
      i = 0
      while i < allCookies.length
        thisCookie = allCookies[i].split "="

        thisCookieName = thisCookie[0].replace /^\s+|\s+$/g, ""
        
        if thisCookieName is name
          cookieFound = true
          
          thisCookieValue = unescape thisCookie[1].replace /^\s+|\s+$/g, "" if thisCookie.length > 1
          
          return thisCookieValue
        thisCookieName = ""
        i++
      null unless cookieFound
    @removeCookie: (key) ->
      document.cookie = key + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;"
    @secondsToMinutes: (seconds) ->
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
    @animLoop: (render, time) ->
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

  Handlebars.registerHelper 'secondsToMinutes', Util.secondsToMinutes

  Util
