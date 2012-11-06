require.config({
    shim: {
        'jquery.bootstrap': {
            deps: ['jquery'],
            exports: 'jquery'
        },
        'notifier': {
            exports: 'Notifier'
        },
        'handlebars': {
            exports: 'Handlebars'
        }
    },
    paths: {
        'jquery': 'vendor/jquery',
        'jquery.bootstrap': 'vendor/bootstrap',
        'handlebars': 'vendor/handlebars',
        'notifier': 'vendor/notifier',
        'backbone': 'vendor/backbone',
        'underscore': 'vendor/underscore',
        'text': 'vendor/text'
    }
});

require(['Router', 'backbone'], function (Router, Backbone) {
    window.Router = Router;
    Backbone.history.start();
});