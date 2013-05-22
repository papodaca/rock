define ["backbone", "models/LibraryModel"], (Backbone, Library) ->
  Backbone.Collection.extend
    model: Library
