define [
  "backbone",
  "jquery",
  "views/LibrariesCollectionView",
  "views/UserView",
  "hbs!template/SettingsView"
], (
  Backbone,
  $,
  LibrariesCollectionView,
  UserView,
  Template
) ->
  Backbone.View.extend
    id: "settings"
    libraries: null
    user: null
    initialize: ->
      @libraries = new LibrariesCollectionView()
      @user = new UserView()
      @render()

    render: ->
      @$el.empty()
      @$el.append @libraries.el
      @$el.append @user.el
      @libraries.delegateEvents()
      @user.delegateEvents()