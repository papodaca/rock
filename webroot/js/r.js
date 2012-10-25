require.config({
    shim: {
        'backbone': {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        'notifier': {
            deps: ['jquery'],
            exports: 'Notifier'
        }
    },
    paths: {
        'jquery': 'vendor/jquery',
        'bootstrap': 'vendor/bootstrap',
        'handlebars': 'vendor/handlebars',
        'notifier': 'vendor/notifier',
        'backbone': 'vendor/backbone',
        'underscore': 'vendor/underscore',
		'text': 'vendor/text'
    }
});

require(['main', 'jquery'], function (main, $, html) {
    $(document).ready(main.init());
});