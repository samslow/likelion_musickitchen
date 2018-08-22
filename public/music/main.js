var moveByElem = function(elem) {
    $(".animate-next").removeClass("animate-next");
    $('.next').addClass("animate-next").removeClass("next");
    var $prev = elem.prev()[0] != null ? elem.prev() : $('li:last-child');
    var $next = elem.next()[0] != null ? elem.next() : $('li:first-child');
    elem.attr('class', 'card active');
    $next.attr('class', 'card next');
    $prev.attr('class', 'card prev');
};

$(document).keydown(function(event) {
    if (event.keyCode == '32') {
        var $elem = $('.prev')
        moveByElem($elem);
    }
  });

var player,time_update_interval = 0;

function onYouTubeIframeAPIReady() {
    player = new YT.Player('video-placeholder', {
        width: 600,
        height: 400,
        videoId: 'Xa0Q0J5tOP0',
        playerVars: {
            color: 'white',
            autoplay: 1,
            playlist: 'taJ60kskkns,FG0fTKAqZ5g'
        },
        events: {
            onReady: initialize
        }
    });
}

function initialize(){
    updateTimerDisplay();
    updateProgressBar();
    clearInterval(time_update_interval);
    time_update_interval = setInterval(function () {
        updateTimerDisplay();
        updateProgressBar();
    }, 1000);
    $('#volume-input').val(Math.round(player.getVolume()));
}

function updateTimerDisplay(){
    $('#current-time').text(formatTime( player.getCurrentTime() ));
    $('#duration').text(formatTime( player.getDuration() ));
}

function updateProgressBar(){
    $('#progress-bar').val((player.getCurrentTime() / player.getDuration()) * 100);
}



// Progress bar
$('#progress-bar').on('mouseup touchend', function (e) {
    var newTime = player.getDuration() * (e.target.value / 100);
    player.seekTo(newTime);

});

// Playback
$('#play-toggle').on('click', function () {
    var play_toggle = $(this);
    if(player.getPlayerState() != 1) {
        player.playVideo();
        play_toggle.text('pause');
    }
    else{
        player.pauseVideo();
        play_toggle.text('play_arrow');
    }
});

// Sound volume
$('#mute-toggle').on('click', function() {
    var mute_toggle = $(this);
    if(player.isMuted()){
        player.unMute();
        mute_toggle.text('volume_up');
    }
    else{
        player.mute();
        mute_toggle.text('volume_off');
    }
});
$('#volume-input').on('change', function () {
    player.setVolume($(this).val());
});

// Playlist
$('#next').on('click', function () {
    player.nextVideo()
});
$('#prev').on('click', function () {
    player.previousVideo()
});

// Time Helper Functions
function formatTime(time){
    time = Math.round(time);
    var minutes = Math.floor(time / 60),
        seconds = time - minutes * 60;
    seconds = seconds < 10 ? '0' + seconds : seconds;
    return minutes + ":" + seconds;
}

function generate() {
    var parentTarget = document.getElementById('card-target');
    parentTarget.lastChild.removeAttribute("id");
    var a = document.createElement('li');
    var valueOfTest = document.getElementById('href').value;
    a.appendChild(document.createTextNode(valueOfTest));
    a.classList.add('card');
    a.setAttribute("id", "card-anchor");
    parentTarget.appendChild(a);
    (function () {
        var anchor = document.getElementById("card-anchor");
        var topPosition = anchor.offsetTop;
        document.getElementById('card-target').scrollTop = topPosition;
    }());
}