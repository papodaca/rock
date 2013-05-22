define ["backbone"], (Backbone) ->
  Backbone.Model.extend
    urlRoot: "api/libraries"
    defaults:
      id: null
      name: null
      path: null
      songs: null
