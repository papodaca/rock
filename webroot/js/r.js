require.config({
    shim: {
        'jquery.bootstrap': {
            deps: ['jquery'],
            exports: 'jquery'
        },
        'backbone': {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
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

require(['views/MainView', 'jquery'], function (MainView, $) {
	var mainView = new MainView();
	$(document.body).html(mainView.el);
});