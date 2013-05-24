define ["backbone"], (Backbone) ->
  Backbone.Model.extend
    urlRoot: "api/libraries"
    defaults:
      id: null
      name: null
      path: null
      songs: null

    validate: (attr) ->
      valid = true
      result = ""
      if attr.name is null or attr.name.length is 0
        valid = false
        result += " nameNull "
      if attr.path is null or attr.path.length is 0
        valid = false
        result += " pathNull "
      result  unless valid