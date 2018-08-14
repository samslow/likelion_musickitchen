class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
      type: "buttons",
      :buttons => ["음악 신청하기", "화면에 메시지 띄우기", "사용 방법"]
    }
    render json: @keyboard
  end
  
  def message
    @user_msg = params[:content] #사용자의 입력값
    
    if @user_msg == "음악 신청하기"
      @text = "YouTube Link를 입력 해 주세요!\n* 길이 5분이내\n* 음악링크만 보내주세요"
    elsif @user_msg == "화면에 메시지 띄우기"
      @text = "화면에 메시지를 띄웁니다."
    elsif @user_msg == "사용 방법"
      @text = "사용방법 있서영? 아뇨 엄서영 ㅜㅜ"
    else
      # @video = RestClient.get("https://www.googleapis.com/youtube/v3/videos?part=snippet&id=G8bTSVo2jYc&key=AIzaSyBr0ucOpgqTMXLNUw_8ePDP8kkaPG87q-E")
      # @text = 
      if @user_msg.include?("?v=")
        @video_id = @user_msg.split('?v=')[1]
        @video = Yt::Video.new id: @video_id
        Music.create(title: @video.title, vid: @video.id)
        @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
      # elsif @user_msg[-12] == "/"
      #   @video_id = @user_msg.last(11)
      #   @video = Yt::Video.new id: @video_id
      #   Music.create(title: @video.title)
      #   @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
      else
        @text = "잘못된 YouTube 주소를 입력하셨습니다."
        @text = @video_id
      end
    end
    
    @return_msg = {
      :text => @text 
    }
    @keyboard_init = {
      :type => "buttons",
      :buttons => ["음악 신청하기", "화면에 메시지 띄우기", "사용 방법"]
    }
    @keyboard_applymusic ={
      :type => "text"
    }
    if @user_msg == "음악 신청하기"
      @result = {
        :message => @return_msg,
        :keyboard => @keyboard_applymusic
      }
    else
      @result = {
        :message => @return_msg,
        :keyboard => @keyboard_init
      }
    end
    render json: @result
  end
  
  def show
    @musics = Music.all
  end
end
