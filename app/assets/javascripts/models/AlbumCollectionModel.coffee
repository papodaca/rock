define [
  "backbone.pageable",
  "models/AlbumModel",
  "lib/Util"
], (
  PageableCollection,
  Album,
  Util
) ->
  PageableCollection.extend
    url: "#{Util.basePath}api/albums"
    model: Album
