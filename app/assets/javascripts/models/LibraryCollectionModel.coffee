define [
  "backbone",
  "models/LibraryModel",
  "lib/Util"
], (
  Backbone,
  Library,
  Util
) ->
  Backbone.Collection.extend
    url: "#{Util.basePath}api/libraries"
    model: Library
