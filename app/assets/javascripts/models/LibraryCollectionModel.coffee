define ["backbone", "models/LibraryModel"], (Backbone, Library) ->
  Backbone.Collection.extend
    url: "api/libraries"
    model: Library
