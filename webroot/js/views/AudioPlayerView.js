define(function(require) {
	var Backbone = require('backbone'),
		Handlebars = require('handlebars'),
		$ = require('jquery'),
		Template = require('text!views/templates/AudioPlayerView.template');
	
	return Backbone.View.extend({
		template: Handlebars.compile(Template),
		initialize: function() {
			this.render();
		},
		render: function() {
			this.$el.append(this.template({}));
		}
	});
});