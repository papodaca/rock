define(['backbone', 'views/MainView', 'views/AttractView', 'views/TestView'], function(Backbone, MainView, AttractView, TestView) {
    return new (Backbone.Router.extend({
        view: new MainView(),
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