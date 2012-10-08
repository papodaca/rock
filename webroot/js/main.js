Templates = {};
function init() {
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

    //$('#registerModal').modal({});
    $("#registerModal").on("hidden", function () {
        $("#registerName").val("");
        $("#registerEmail").val("");
        $("#registerPassword").val("");
        $("#registerPassword2").val("");
    })

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


function handleLoginButton() {
    if($("#loginEmailTextBox").val() === "") {
        $("#loginEmailTextBox").addClass("error");
    }
    if($("#loginPasswordTextBox").val() === "") {
        $("#loginPasswordTextBox").addClass("error");
    }

}