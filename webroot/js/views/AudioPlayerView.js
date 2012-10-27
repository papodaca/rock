define(function(require) {
    var Backbone = require('backbone'),
        Handlebars = require('handlebars'),
        $ = require('jquery'),
        Template = require('text!views/templates/AudioPlayerView.template');
    
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
            this.animLoop(this.thisLoop, 250, this);
            this.audioPlayer = this.$("#audioPlayer").get(0);
        },
        render: function() {
            this.$el.append(this.template({}));
        },
        calculatePercentage: function (x, width) {
            return (x / width) * 100;
        },
        secondsToMinutes: function (seconds) {
            var minutes = Math.floor(seconds / 60);
            var hours = 0;
            var result = ""
            if (minutes > 60) {
                hours = Math.floor(minutes / 60);
                minutes = Math.floor(minutes % 60);
                result += hours + ":";
                if (minutes < 10) {
                    result += "0";
                }
            }
            var seconds = Math.floor(seconds % 60);
            result += minutes + ":";
            if (seconds < 10) {
                result += "0";
            }
            result += seconds;
            return result;
        },
        volumeButtonClick: function(event) {
                var p = $(event.currentTarget).offset();
                p.left = p.left - (this.$("#volumePopover").width() / 2) + (this.$(event.currentTarget).outerWidth(false) / 2);
                p.top = p.top - $("#volumePopover").outerHeight(true) + 10;
                this.$("#volumePopover").offset(p);

                this.$("#volumePopover").toggleClass("out");
                this.$("#volumePopover").toggleClass("in");
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
            var width = this.$("#volumeSlider #slider div.bar").css("width").replace("px", ""); ;
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
        resize: function(_this) {
            if(_this.audioPlayer.src === "") {
                _this.$("#playProgress").addClass("hidden");
                _this.$("#playbackBar").addClass("hidden");
            } else {
                
                var newPlaybackWidth = _this.$("#playProgress").offset().left - 15 - (_this.$("#plabackControls").offset().left + _this.$("#plabackControls").outerWidth(true));
                var width = _this.$("#playbackBar").css("width");
                var regex = /[^0-9]/g;
                if (regex.exec(width)[0] !== newPlaybackWidth) {
                    _this.$("#playbackBar").css("width", newPlaybackWidth + "px");
                }

                _this.$("#playProgress").removeClass("hidden");
                _this.$("#playbackBar").removeClass("hidden");
            }
        },
        thisLoop: function (deltaT, _this) {
            try {
                if (!$("#bottomNavBar").hasClass("hidden")) {
                    _this.resize(_this);
                    

                    var playStatus = _this.secondsToMinutes(_this.audioPlayer.currentTime) + " / ";
                    playStatus += _this.secondsToMinutes(_this.audioPlayer.duration);
                    var percent = _this.calculatePercentage(_this.audioPlayercurrentTime, _this.audioPlayer.duration);
                    var percent_buffered = _this.calculatePercentage(_this.audioPlayer.buffered.end(0) - _this.audioPlayer.currentTime, _this.audioPlayer.duration);

                    _this.$("#playProgress a.brand").html(playStatus);
                    _this.$("#playbackBar div.progress div.bar").css("width", percent + "%");
                    _this.$("#playbackBar div.progress div.bar-info").css("width", percent_buffered + "%");
                }
            } catch (e) {

            }
        },
        animLoop: function (render, time, _this) {
            var running, lastFrame = +new Date,
                raf = window.mozRequestAnimationFrame ||
                        window.webkitRequestAnimationFrame ||
                        window.msRequestAnimationFrame ||
                        window.oRequestAnimationFrame;
            function loop(now) {
                // stop the loop if render returned false
                if (running !== false) {
                    raf(loop, null);
                    var deltaT = now - lastFrame;
                    if (deltaT > time) {
                        running = render(deltaT, _this);
                        lastFrame = now;
                    }
                }
            };
            loop(lastFrame);
        }
    });
});

