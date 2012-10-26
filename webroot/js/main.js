define(function (require) {
    var $ = require('jquery'),
        HandleBars = require('handlebars'),
		BootStrap = require('bootstrap'),
        Backbone = require('backbone'),
		Notifier = require('notifier');
		
    return new (Backbone.Model.extend({
        Templates: {},
        __this: {},
		
        /*setupHandlebars: function () {
            var names = ['album'];
            for (i in names) {
                _this.Templates[names[i]] = Handlebars.compile($('script#' + names[i] + '[type="text/x-handlebars-template"]').html());
            }


            Handlebars.registerHelper('secondsToMinutes', function (seconds) {
                var result = Math.floor(seconds / 60) + ":";
                if (seconds % 60 < 10) {
                    result += "0"
                }
                result += (seconds % 60);

                return new Handlebars.SafeString(result);
            });
            Handlebars.registerHelper("TrackNr", function (seconds) {
                return _this["@attr"]["rank"];
            });
            Handlebars.registerHelper("getArt", function (seconds) {
                return _this.album.image[2]["#text"];
            });
        },*/
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
        init: function () {
            _this = this;
            //_this.setupHandlebars();

            $("#registerModal").on("hidden", function () {
                $("#registerName").val("");
                $("#registerEmail").val("");
                $("#registerPassword").val("");
                $("#registerPassword2").val("");
                $("#registerSubmitButton").removeClass("disabled loading");
            })

            $("#registerSubmitButton").click(function () {
                $("#registerPassword").parent().parent().removeClass("error");
                $("#registerPassword2").parent().parent().removeClass("error");
                $("#registerPasswordLabel").addClass("hidden");
                $("#registerEmailLabel").addClass("hidden");
                if ($("#registerPassword").val() === $("#registerPassword2").val()) {
                    $(this).addClass("disabled loading");
                    data = {
                        "name": $("#registerName").val(),
                        "email": $("#registerEmail").val(),
                        "password": $("#registerPassword").val()
                    };

                    $.ajax({
                        type: "POST",
                        url: "users.json",
                        data: data,
                        success: function (msg) {
                            $("#registerModal").modal("hide");
                            Notifier.success("Registration successful.");
                        },
                        error: function (msg) {
                            if (msg.status === 400) {
                                if (msg.responseText.indexOf("Email in use.") != -1) {
                                    $("#registerEmailLabel").html("Email in use.").toggleClass("hidden");
                                    $("#registerSubmitButton").removeClass("disabled loading");
                                }
                            } else {
                                console.log(msg);
                                document.write(msg.responseText);
                            }
                        }
                    });
                } else {
                    $("#registerPasswordLabel").html("Passwords do not match").toggleClass("hidden");
                    $("#registerPassword").parent().parent().addClass("error");
                    $("#registerPassword2").parent().parent().addClass("error");
                }


            });

            $("#loginButton").click(function () {
                $(this).addClass("disabled loading");
            });

            $('#volumeButton').click(function () {
                var p = $(this).offset();
                p.left = p.left - ($("#volumePopover").width() / 2) + ($(this).outerWidth(false) / 2);
                p.top = p.top - $("#volumePopover").outerHeight(true) + 10;
                $("#volumePopover").offset(p);

                $("#volumePopover").toggleClass("out");
                $("#volumePopover").toggleClass("in");
            });

            $('#muteButton').click(function () {
                $(this).toggleClass("btn-danger");
                var audio = document.getElementById("audioPlayer");
                if (audio.muted) {
                    audio.muted = false;
                } else {
                    audio.muted = true;
                }
            });

            $("#volumeSlider #slider").click(function (event) {
                var percent = _this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
                $("#volumeSlider #slider div.bar").css("width", percent + "%");
                $("#volumeSlider #echo").html(Math.ceil(percent) + "%");

                var audio = document.getElementById("audioPlayer");
                audio.volume = percent / 100;
            });

            $("#volumeSlider #slider").mousemove(function (event) {
                var percent = _this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
                $("#volumeSlider #echo").html(Math.ceil(percent) + "%");
            });

            $("#volumeSlider #slider").mouseout(function (event) {
                var width = $("#volumeSlider #slider div.bar").css("width").replace("px", ""); ;
                var percent = _this.calculatePercentage(width, event.currentTarget.clientWidth);
                $("#volumeSlider #echo").html(Math.ceil(percent) + "%");
            });

            $("#playPauseButton").click(function (event) {
                var audio = document.getElementById("audioPlayer");
                if (audio.paused == false) {
                    audio.pause();
                } else {
                    audio.play();
                }
                $("#playPauseButton i").toggleClass("icon-play");
                $("#playPauseButton i").toggleClass("icon-pause");
            });

            $("#playbackBar div.progress").click(function (event) {
                var audio = document.getElementById("audioPlayer");

                if (audio.seekable && audio.seekable.length > 0) {
                    var percent = _this.calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
                    $("#playbackBar div.progress div.bar").css("width", percent + "%");
                    audio.currentTime = audio.duration * (percent / 100);
                }

            });
            $(window).resize(function () {
                $("#playbackBar").css("width", _this.resizePlaybackBar() + "px");
            });
            _this.animLoop(function (deltaT) {
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
            }, 250);

        },
        resizePlaybackBar: function () {
            return $("#playProgress").offset().left - 15 - ($("#plabackControls").offset().left + $("#plabackControls").outerWidth(true));
        },
        animLoop: function (render, time) {
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
                        running = render(deltaT);
                        lastFrame = now;
                    }
                }
            }
            loop(lastFrame);
        }

    }))();
});