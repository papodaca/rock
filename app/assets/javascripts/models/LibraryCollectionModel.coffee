define [
  "backbone",
  "models/LibraryModel",
  "Util"
], (
  Backbone,
  Library,
  Util
) ->
  Backbone.Collection.extend
    url: "#{Util.basePath}api/libraries"
    model: Library
