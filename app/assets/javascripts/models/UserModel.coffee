define ["backbone"], (Backbone) ->
  Backbone.Model.extend
    url: "users.json"
    defaults:
      id: null
      email: null
      name: null
      password: null

    validate: (attr) ->
      valid = true
      result = ""
      if attr.name is null or attr.name.length is 0
        valid = false
        result += " nameNull "
      if attr.email is null or attr.email.length is 0
        valid = false
        result += " emailNull "
      else unless @validateEmail(attr.email)
        valid = false
        result += " emailInvalid "
      if attr.password isnt attr.password2
        valid = false
        result += " passwordMismatch "
      else if attr.password is null or attr.password.length is 0
        valid = false
        result += " passwordNull "
      result  unless valid

    validateEmail: (email) ->
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      re.test email


