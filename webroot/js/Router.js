define(['backbone', 'views/MainView', 'views/AttractView'], function(Backbone, MainView, AttractView) {
    return new (Backbone.Router.extend({
        view: new MainView({socket: new AttractView()}),
        routes: {
            "": "base"
        },
        initialize: function() {
            $('body').append(this.view.el);
            this.base();
        },
        base: function() {
            this.view.setSocket(new AttractView());
        }
    }))();
});