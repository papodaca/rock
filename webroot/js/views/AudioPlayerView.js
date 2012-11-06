define([
    'backbone',
    'underscore',
    'handlebars',
    'jquery',
    'text!views/templates/AudioPlayerView.hbs'],
    function(Backbone, _, Handlebars, $, Template) {
    
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
        audioPlayer: null,
        events: {
            "click #volumeButton": "volumeButtonClick",
            "click #muteButton": "muteButtonClick",
            "click #volumeSlider #slider": "volumeSliderClick",
            "click #playPauseButton": "playPauseButtonClick",
            "mousemove #volumeSlider #slider": "volumeSliderMouseMove",
            "mouseout #volumeSlider #slider": "volumeSliderMouseOut",
            "click #playbackBar div.progress": "playbackBarClick"
        },
        initialize: function() {
            this.render();
            this.animLoop(_.bind(this.thisLoop, this), 250);
            this.audioPlayer = this.$("#audioPlayer").get(0);
        },
        render: function() {
            this.$el.append(this.template({}));
            this.volumePopoverLocation(true);
        },
        calculatePercentage: function (x, width) {
            return (x / width) * 100;
        },
        secondsToMinutes: function (seconds) {
            var minutes = Math.floor(seconds / 60);
            var hours = 0;
            var result = "";
            if (minutes > 60) {
                hours = Math.floor(minutes / 60);
                minutes = Math.floor(minutes % 60);
                result += hours + ":";
                if (minutes < 10) {
                    result += "0";
                }
            }
            seconds = Math.floor(seconds % 60);
            result += minutes + ":";
            if (seconds < 10) {
                result += "0";
            }
            result += seconds;
            return result;
        },
        volumePopoverVisible: false,
        volumeButtonClick: function(event) {
            this.volumePopoverLocation();
            if(!this.volumePopoverVisible) {
                this.$("#volumePopover").css("display", "block");
                _.delay(function() {
                    this.$("#volumePopover").removeClass("out");
                    this.$("#volumePopover").addClass("in");
                }, 5, this);
                this.volumePopoverVisible = true;
            } else {
                this.$("#volumePopover").removeClass("in");
                this.$("#volumePopover").addClass("out");
                _.delay(function() {
                    this.$("#volumePopover").css("display", "none");
                }, 250, this);
                this.volumePopoverVisible = false;
            }
        },
        volumePopoverLocation: function(force) {
            var button = this.$("#volumeButton");
            var popover = this.$("#volumePopover .popover-content");
            var p = button.offset();
            if(this.$("#volumePopover").css("display") !== "none" || force) {
                p.left = p.left - (popover.outerWidth(true) / 2) + (button.outerWidth() / 2);
                p.top = p.top - (popover.outerHeight(true) / 2) - (button.outerHeight() / 2);
                this.$("#volumePopover").css("top", p.top+"px");
                this.$("#volumePopover").css("left", p.left-30+"px");
            }
        },
        muteButtonClick: function(event) {
            this.$(event.currentTarget).toggleClass("btn-danger");
            if (this.audioPlayer.muted) {
                this.audioPlayer.muted = false;
            } else {
                this.audioPlayer.muted = true;
            }
        },
        playPauseButtonClick: function(event) {
            if(this.audioPlayer.src !== "") {
                if (this.audioPlayer.paused === false) {
                    this.audioPlayerpause();
                } else {
                    this.audioPlayer.play();
                }
                this.$("#playPauseButton i").toggleClass("icon-play");
                this.$("#playPauseButton i").toggleClass("icon-pause");
            }
        },
        volumeSliderClick: function(event) {
            var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
            this.$("#volumeSlider #slider div.bar").css("width", percent + "%");
            this.$("#volumeSlider #echo").html(Math.ceil(percent) + "%");

            this.audioPlayer.volume = percent / 100;
        },
        volumeSliderMouseMove: function(event) {
            var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
            this.$("#volumeSlider #echo").html(Math.ceil(percent) + "%");
        },
        volumeSliderMouseOut: function(event) {
            var width = this.$("#volumeSlider #slider div.bar").css("width").replace("px", "");
            var percent = this.calculatePercentage(width, event.currentTarget.clientWidth);
            this.$("#volumeSlider #echo").html(Math.ceil(percent) + "%");
        },
        playbackBarClick: function(event) {
            if (this.audioPlayer.seekable && this.audioPlayer.seekable.length > 0) {
                var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
                this.$("#playbackBar div.progress div.bar").css("width", percent + "%");
                this.audioPlayer.currentTime = this.audioPlayer.duration * (percent / 100);
            }
        },
        resize: function() {
            this.volumePopoverLocation();
            if(this.audioPlayer.src === "") {
                this.$("#playProgress").addClass("hidden");
                this.$("#playbackBar").addClass("hidden");
            } else {
                
                var newPlaybackWidth = this.$("#playProgress").offset().left - 15 - (this.$("#plabackControls").offset().left + this.$("#plabackControls").outerWidth(true));
                var width = this.$("#playbackBar").css("width");
                var regex = /[^0-9]/g;
                if (regex.exec(width)[0] !== newPlaybackWidth) {
                    this.$("#playbackBar").css("width", newPlaybackWidth + "px");
                }

                this.$("#playProgress").removeClass("hidden");
                this.$("#playbackBar").removeClass("hidden");
            }
        },
        thisLoop: function (deltaT) {
            try {
                if(!$("#bottomNavBar").hasClass("hidden")) {
                    this.resize();
                    
                    if(this.audioPlayer.src !== "") {
                        var playStatus = this.secondsToMinutes(this.audioPlayer.currentTime) + " / ";
                        playStatus += this.secondsToMinutes(this.audioPlayer.duration);
                        var percent = this.calculatePercentage(this.audioPlayercurrentTime, this.audioPlayer.duration);
                        var percent_buffered = this.calculatePercentage(this.audioPlayer.buffered.end(0) - this.audioPlayer.currentTime, this.audioPlayer.duration);

                        this.$("#playProgress a.brand").html(playStatus);
                        this.$("#playbackBar div.progress div.bar").css("width", percent + "%");
                        this.$("#playbackBar div.progress div.bar-info").css("width", percent_buffered + "%");
                    }
                }
            } catch (e) {
                return true;
            }
            return true;
        },
        animLoop: function (render, time) {
            var running;
            var lastFrame = new Date();
            var raf = window.mozRequestAnimationFrame ||
                        window.webkitRequestAnimationFrame ||
                        window.msRequestAnimationFrame ||
                        window.oRequestAnimationFrame;
            var loop = function(now) {
                // stop the loop if render returned false
                if (running !== false) {
                    raf(loop, null);
                    var deltaT = now - lastFrame;
                    if (deltaT > time) {
                        running = render(deltaT);
                        lastFrame = now;
                    }
                }
            };
            loop(lastFrame);
        }
    });
});

