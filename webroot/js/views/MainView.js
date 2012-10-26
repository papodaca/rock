define(function(require) {
	var Backbone = require('backbone'),
		Handlebars = require('handlebars'),
		$ = require('jquery'),
		HeaderView = require('views/HeaderView'),
		AudioPlayerView = require('views/AudioPlayerView'),
		Template = require('text!views/templates/MainView.template');
	
	return Backbone.View.extend({
		template: Handlebars.compile(Template),
		header: new HeaderView(),
		audioPlayer: new AudioPlayerView(),
		initialize: function() {
			this.render();
		},
		render: function() {
			this.$el.append(this.header.el);
			this.$el.append(this.template({}));
			this.$el.append(this.audioPlayer.el);
			this.$el.append('<div id="notificationContainer"></div>');
		}
	});
});