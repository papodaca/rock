define ["backbone"], (Backbone) ->
  Backbone.Model.extend
    url: "libraries"
    defaults:
      id: null
      name: null
      path: null
      songs: null
