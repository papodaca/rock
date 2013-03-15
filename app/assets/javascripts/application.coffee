require.config
  'shim':
    'jquery.bootstrap':
      'deps': ['jquery']
      'exports': 'jquery'
    'notifier':
      'exports': 'Notifier'
    'handlebars':
      'exports': 'Handlebars'
  'paths':
    'jquery': 'vendor/jquery',
    'jquery.bootstrap': 'vendor/bootstrap',
    'handlebars': 'vendor/handlebars',
    'notifier': 'vendor/notifier',
    'backbone': 'vendor/backbone',
    'underscore': 'vendor/underscore',
    'json2': 'vendor/json2',
    'i18nprecompile': 'vendor/i18nprecompile',
    'hbs': 'vendor/hbs'
  'hbs': 
    'disableI18n': true

require ['Router', 'backbone'], (Router, Backbone) ->
  window.Router = Router
  Backbone.history.start()
