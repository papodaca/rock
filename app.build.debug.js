({
    appDir: "webroot.src",
    baseUrl: "js",
    dir: "webroot",
    removeCombined: true,
    optimize: "none",
    modules: [{
        name: "main"
    }],
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
})