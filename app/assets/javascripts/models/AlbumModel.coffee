define [
  "backbone",
  "lib/Util"
], (
  Backbone,
  Util
) ->
  Backbone.Model.extend
    urlRoot: "#{Util.basePath}api/albums"
    defaults:
      id: null
      name: null
      tracks: null
      length: null
      artist: null
      art: null
