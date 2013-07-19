define [
  "backbone",
  "lib/Util"
], (
  Backbone,
  Util
) ->
  Backbone.Model.extend
    urlRoot: "#{Util.basePath}api/libraries"
    defaults:
      id: null
      name: null
      path: null
      progress: null
      songs: null

    validate: (attr) ->
      valid = true
      result = ""
      if attr.name is null or attr.name.length is 0
        valid = false
        result += " nameNull "
      if attr.path is null or attr.path.length is 0
        valid = false
        result += " pathNull "
      result  unless valid

    scan: (opts) ->
      url = @.url() + "/scan"
      options =
        url: url
        type: "POST"
      _.extend(options, opts)
      (this.sync || Backbone.sync).call(this, null, this, options);