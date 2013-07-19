define [
  "backbone",
  "lib/Util"
], (
  Backbone,
  Util
) ->
  Backbone.Model.extend
    urlRoot: "#{Util.basePath}api/songs"
    defaults:
      id: null
      title: null
      track: null
      length: null
      artist: null
      album: null
      genre: null
