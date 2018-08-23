
/*유튜브 플레이어 정의*/
var player,time_update_interval = 0;

function onYouTubeIframeAPIReady() {
    player = new YT.Player('video-placeholder', {
        width: 600,
        height: 400,
        videoId: 'pHYWdjBmRm8',
        playerVars: {
            color: 'white',
            autoplay: 1,
            playlist: playlist.join(','),
        },
        events: {
            onReady: initialize,
            onStateChange: stateChange
        }
    });
}
/* 유튜브 컨트롤러 정의*/
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

// 수노의 개꿀딱 코드 복사
function stateChange(e){
  if(event.data == -1) {
      console.log("gogo")
      // get current video index
      var index = player.getPlaylistIndex();
      // update when playlists do not match
      if(player.getPlaylist().length != playlist.length) {
        // update playlist and start playing at the proper index
        player.loadPlaylist(playlist, previousIndex+1);
      }
      previousIndex = index;
  }
}

// 우선 예약 코드
function super_booking(data) {
  playlist.splice(previousIndex, 0 ,data.vid)
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

/* 텍스트 메세지 생성자*/
function generate() {
    var parentTarget = document.getElementById('card-target');
    parentTarget.lastChild.removeAttribute("id");
    var a = document.createElement('li');
    var valueOfTest = document.getElementById('href').value; /*현재 테스트용 텍스트 입력을 받으면 여기서 벨류 받아와서 들어감 여기로 메세지 넣으면 될듯*/
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
