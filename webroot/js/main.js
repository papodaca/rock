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
    return Math.ceil((x / width)*100) + "%";
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
    });

    $("#volumeSlider #slider").click(function(event) {
        var percent = calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
        $("#volumeSlider #slider div.bar").css("width", percent );
        $("#volumeSlider #echo").html(percent);
    });

    $("#volumeSlider #slider").mousemove(function(event) {
        var percent = calculatePercentage(event.offsetX, event.currentTarget.clientWidth);
        $("#volumeSlider #echo").html(percent);
    });

    $("#volumeSlider #slider").mouseout(function (event) {
        var width = $("#volumeSlider #slider div.bar").css("width").replace("px","");;
        var percent = calculatePercentage(width, event.currentTarget.clientWidth);
        $("#volumeSlider #echo").html(percent);
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
