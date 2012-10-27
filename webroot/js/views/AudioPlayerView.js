define(function(require) {
    var Backbone = require('backbone'),
        Handlebars = require('handlebars'),
        $ = require('jquery'),
        Template = require('text!views/templates/AudioPlayerView.template');
    
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
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
            this.resize();
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
                p.left = p.left - ($("#volumePopover").width() / 2) + ($(event.currentTarget).outerWidth(false) / 2);
                p.top = p.top - $("#volumePopover").outerHeight(true) + 10;
                $("#volumePopover").offset(p);

                $("#volumePopover").toggleClass("out");
                $("#volumePopover").toggleClass("in");
        },
        muteButtonClick: function(event) {
                $(event.currentTarget).toggleClass("btn-danger");
                var audio = document.getElementById("audioPlayer");
                if (audio.muted) {
                    audio.muted = false;
                } else {
                    audio.muted = true;
                }
        },
        playPauseButtonClick: function(event) {
                var audio = document.getElementById("audioPlayer");
                if (audio.paused == false) {
                    audio.pause();
                } else {
                    audio.play();
                }
                $("#playPauseButton i").toggleClass("icon-play");
                $("#playPauseButton i").toggleClass("icon-pause");
        },
        volumeSliderClick: function(event) {
            var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
            $("#volumeSlider #slider div.bar").css("width", percent + "%");
            $("#volumeSlider #echo").html(Math.ceil(percent) + "%");

            var audio = document.getElementById("audioPlayer");
            audio.volume = percent / 100;
        },
        volumeSliderMouseMove: function(event) {
            var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
            $("#volumeSlider #echo").html(Math.ceil(percent) + "%");
        },
        volumeSliderMouseOut: function(event) {
            var width = $("#volumeSlider #slider div.bar").css("width").replace("px", ""); ;
            var percent = this.calculatePercentage(width, event.currentTarget.clientWidth);
            $("#volumeSlider #echo").html(Math.ceil(percent) + "%");
        },
        playbackBarClick: function(event) {
            var audio = document.getElementById("audioPlayer");

            if (audio.seekable && audio.seekable.length > 0) {
                var percent = this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
                $("#playbackBar div.progress div.bar").css("width", percent + "%");
                audio.currentTime = audio.duration * (percent / 100);
            }
        },
        resize: function() {
            this.$("#playbackBar").css("width", this.resizePlaybackBar() + "px");
        },
        resizePlaybackBar: function () {
            return this.$("#playProgress").offset().left - 15 - (this.$("#plabackControls").offset().left + this.$("#plabackControls").outerWidth(true));
        },
        thisLoop: function (deltaT, _this) {
            try {
                if (!$("#bottomNavBar").hasClass("hidden")) {
                    var audio = document.getElementById("audioPlayer");
                    var playStatus = _this.secondsToMinutes(audio.currentTime) + " / ";
                    playStatus += _this.secondsToMinutes(audio.duration);
                    var percent = _this.calculatePercentage(audio.currentTime, audio.duration);
                    var percent_buffered = _this.calculatePercentage(audio.buffered.end(0) - audio.currentTime, audio.duration);

                    $("#playProgress a.brand").html(playStatus);
                    $("#playbackBar div.progress div.bar").css("width", percent + "%");
                    $("#playbackBar div.progress div.bar-info").css("width", percent_buffered + "%");

                    var newPlaybackWidth = resizePlaybackBar();
                    if ($("#playbackBar").css("width") !== newPlaybackWidth) {
                        $("#playbackBar").css("width", newPlaybackWidth + "px");
                    }
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
            }
            loop(lastFrame);
        }
    });
});

