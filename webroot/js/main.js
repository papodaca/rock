var Templates = {};

function setupHandlebars() {
    Templates["album"] = Handlebars.compile($("#albumTemplate").html());

    Handlebars.registerHelper('secondsToMinutes', function (seconds) {
        var result = Math.floor(seconds / 60) + ":";
        if (seconds % 60 < 10) {
            result += "0"
        }
        result += (seconds % 60);

        return new Handlebars.SafeString(result);
    });
    Handlebars.registerHelper("TrackNr", function (seconds) {
        return this["@attr"]["rank"];
    });
    Handlebars.registerHelper("getArt", function (seconds) {
        return this.album.image[2]["#text"];
    });
}

function calculatePercentage(x, width) {
    return (x / width)*100;
}

function secondsToMinutes(seconds) {
    var minutes = Math.floor(seconds / 60);
	var hours = 0;
	var result = ""
	if(minutes > 60) {
		hours = Math.floor(minutes / 60);
		minutes = Math.floor(minutes % 60);
		result += hours + ":";
		if(minutes < 10) {
			result += "0";
		}
	}
    var seconds = Math.floor(seconds % 60);
    result += minutes + ":";
    if(seconds < 10) {
        result += "0";
    }
    result += seconds;
    return result;
}

function init() {
    setupHandlebars();

    $("#registerModal").on("hidden", function () {
        $("#registerName").val("");
        $("#registerEmail").val("");
        $("#registerPassword").val("");
        $("#registerPassword2").val("");
        $("#registerSubmitButton").removeClass("disabled loading");
    })

    $("#registerSubmitButton").click(function () {
        $(this).addClass("disabled loading");
    });

    $("#loginButton").click(function () {
        $(this).addClass("disabled loading");
    });

    $('#volumeButton').click(function () {
        var p = $(this).offset();
        p.left = p.left - ($("#volumePopover").width() / 2) + ($(this).outerWidth(true) / 2);
        p.top = p.top - $("#volumePopover").outerHeight(true) + 5;
        $("#volumePopover").offset(p);

        $("#volumePopover").toggleClass("out");
        $("#volumePopover").toggleClass("in");
    });

    $('#muteButton').click(function () {
        $(this).toggleClass("btn-danger");
        var audio = document.getElementById("audioPlayer");
        if(audio.muted) {
            audio.muted = false;
        } else {
            audio.muted = true;
        }
    });

    $("#volumeSlider #slider").click(function(event) {
        var percent = calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
        $("#volumeSlider #slider div.bar").css("width", percent + "%");
        $("#volumeSlider #echo").html(Math.ceil(percent) + "%");

        var audio = document.getElementById("audioPlayer");
        audio.volume = percent / 100;
    });

    $("#volumeSlider #slider").mousemove(function(event) {
        var percent = calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
        $("#volumeSlider #echo").html(Math.ceil(percent) + "%");
    });

    $("#volumeSlider #slider").mouseout(function (event) {
        var width = $("#volumeSlider #slider div.bar").css("width").replace("px","");;
        var percent = calculatePercentage(width, event.currentTarget.clientWidth);
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

        if(audio.seekable && audio.seekable.length > 0) {
            var percent = calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
            $("#playbackBar div.progress div.bar").css("width", percent + "%");
            audio.currentTime = audio.duration * (percent / 100);
        }
        
    });


    /*$.ajax({
        type: 'GET',
        dataType: 'jsonp',
        url: 'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=b25b959554ed76058ac220b7b2e0a026&artist=Armin%20van%20Buuren&album=76&format=json',
        success: function (msg) {
            $("#content").append(Templates.album(msg));
        }
    });*/


}
$(document).ready(init);



$(window).resize(function (event) {
	var progressBarWidth = $("#playProgress").offset().left - 15 - ($("#plabackControls").offset().left + $("#plabackControls").outerWidth(true));
	
	$("#playbackBar").css("width", progressBarWidth + "px");
});


function animLoop( render, time) {
    var running, lastFrame = +new Date,
        raf = window.mozRequestAnimationFrame    ||
              window.webkitRequestAnimationFrame ||
              window.msRequestAnimationFrame     ||
              window.oRequestAnimationFrame;
    function loop( now ) {
        // stop the loop if render returned false
        if ( running !== false ) {
            raf( loop, null );
            var deltaT = now - lastFrame;
            if ( deltaT > time ) {
                running = render( deltaT );
                lastFrame = now;
            }
        }
    }
    loop( lastFrame );
}

//main Loop
animLoop(function (deltaT) {
	try {
		var audio = document.getElementById("audioPlayer");
		var playStatus = secondsToMinutes(audio.currentTime) + " / ";
		playStatus += secondsToMinutes(audio.duration);
		var percent = calculatePercentage(audio.currentTime, audio.duration);
		var percent_buffered = calculatePercentage(audio.buffered.end(0) - audio.currentTime, audio.duration);

		$("#playProgress a.brand").html(playStatus);
		$("#playbackBar div.progress div.bar").css("width", percent + "%");
		$("#playbackBar div.progress div.bar-info").css("width", percent_buffered + "%");
	} catch (e) {
		
	}
}, 250);