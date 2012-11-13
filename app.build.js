({
    appDir: "webroot.tmp",
    baseUrl: "js",
    dir: "webroot",
    optimizeCss: "standard",
    removeCombined: true,
    paths: {
        'jquery': 'vendor/jquery',
        'jquery.bootstrap': 'vendor/bootstrap',
        'handlebars': 'vendor/handlebars',
        'notifier': 'vendor/notifier',
        'backbone': 'vendor/backbone',
        'underscore': 'vendor/underscore',
        'json2': 'vendor/json2',
        'i18nprecompile': 'vendor/i18nprecompile',
        'hbs': 'vendor/hbs'
    },
    modules: [
        {
            name: "main"
        }
    ],
    shim: {
        'jquery.bootstrap': {
            deps: ['jquery'],
            exports: 'jquery'
        },
        notifier: {
            exports: 'Notifier'
        }
    },
    hbs: {
        templateExtension : 'hbs',
        disableI18n : true
    }
})