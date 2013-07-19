define [
  "backbone.pageable",
  "models/SongModel",
  "lib/Util"
], (
  PageableCollection,
  Song,
  Util
) ->
  PageableCollection.extend
    url: "#{Util.basePath}api/songs"
    model: Song
