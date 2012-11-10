define(['backbone', 'views/MainView', 'views/AttractView'], function(Backbone, MainView, AttractView) {
    var getRouter =  _.once(function() { 
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
    //this is supposed to be a singleton but it does not work.
    return getRouter();
});