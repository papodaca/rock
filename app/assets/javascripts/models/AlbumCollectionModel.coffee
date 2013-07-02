define [
  "backbone.pageable",
  "models/AlbumModel",
  "Util"
], (
  PageableCollection,
  Album,
  Util
) ->
  PageableCollection.extend
    url: "#{Util.basePath}api/albums"
    model: Album
