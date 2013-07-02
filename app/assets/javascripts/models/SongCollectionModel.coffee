define [
  "backbone.pageable",
  "models/SongModel",
  "Util"
], (
  PageableCollection,
  Song,
  Util
) ->
  PageableCollection.extend
    url: "#{Util.basePath}api/songs"
    model: Song
