class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
      type: "buttons",
      :buttons => ["음악 신청하기", "화면에 메시지 띄우기"]
    }
    render json: @keyboard
  end
  $choice_flag = 0
  def message
    @user_msg = params[:content] #사용자의 입력값
     #0일때 음악, 1일때 메시지
    if @user_msg == "음악 신청하기"
      @text = "YouTube Link를 입력 해 주세요!\n* 길이 5분이내\n* 음악링크만 보내주세요"
    elsif @user_msg == "화면에 메시지 띄우기"
      @text = "화면에 메시지를 띄웁니다.\n메시지를 적어주세요"
      $choice_flag = 1
    else
      if ($choice_flag == 0)
        if @user_msg.include?("?v=")
          @video_id = @user_msg.split('?v=')[1]
          @video = Yt::Video.new id: @video_id
          Music.create(title: @video.title, vid: @video.id)
          @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
        elsif @user_msg[-12] == "/"
          @video_id = @user_msg.last(11)
          @video = Yt::Video.new id: @video_id
          Music.create(title: @video.title, vid: @video.id)
          @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
        else
          @text = "잘못된 YouTube 주소를 입력하셨습니다."
        end
      elsif ($choice_flag == 1)
        Message.create(body: @user_msg)
        @text = "전광판으로 \n \"#{@user_msg}\" \n 을(를) 보냈습니다."
        $choice_flag == 0
      end
    end

    @return_msg = {
      :text => @text
    }
    @keyboard_init = {
      :type => "buttons",
      :buttons => ["음악 신청하기", "화면에 메시지 띄우기"]
    }
    @keyboard_applytext ={
      :type => "text"
    }
    if @user_msg == "음악 신청하기"
      @result = {
        :message => @return_msg,
        :keyboard => @keyboard_applytext
      }
    elsif @user_msg == "화면에 메시지 띄우기"
      @result = {
        message:  @return_msg,
        :keyboard => @keyboard_applytext
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
    @vids = @musics.pluck("vid")
    @playlists = @musics.to_json
  end

  def remocon
    @musics = Music.all
  end
end
