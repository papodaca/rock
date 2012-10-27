define(function(require) {
	var Backbone = require('backbone'),
		Handlebars = require('handlebars'),
		$ = require('jquery'),
		HeaderView = require('views/HeaderView'),
		AudioPlayerView = require('views/AudioPlayerView'),
		Template = require('text!views/templates/MainView.template');
	
	return new (Backbone.View.extend({
		el: $('body'),
		template: Handlebars.compile(Template),
		header: new HeaderView(),
		audioPlayer: new AudioPlayerView(),
		initialize: function() {
			this.render();
			$(window).bind("resize.app", _.bind(this.resize, this));
		},
		render: function() {
			this.$el.append(this.header.el);
			this.$el.append(this.template({}));
			this.$el.append(this.audioPlayer.el);
			this.$el.append('<div id="notificationContainer"></div>');
		},
		resize: function() {
			this.audioPlayer.resize(this.audioPlayer);
		},
		remove: function() {
			$(window).unbind("resize.app");

			Backbone.View.prototype.remove.call(this);
		}
	}))();
});