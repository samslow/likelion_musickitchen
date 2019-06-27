class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
      type: "buttons",
      :buttons => ["음악 신청하기", "화면에 메시지 띄우기"]
    }
    render json: @keyboard
  end
  
  def message
    if User.find_by(key: params[:user_key])
      p "유저가 있음"
    else
      p "노 유저"
      if User.create(key: params[:user_key])
        p "유저 생성됨"
      end
    end
    
    @user_msg = params[:content] #사용자의 입력값
    @cuser = User.find_by(key: params[:user_key])
        
    if @user_msg == "음악 신청하기"
      @text = "YouTube Link를 입력 해 주세요!\n* 길이 5분이내\n* 음악링크만 보내주세요"
    elsif @user_msg == "화면에 메시지 띄우기"
      @text = "화면에 메시지를 띄웁니다.\n메시지를 적어주세요"
      @cuser.update(flag:1)
    else
      if @cuser.flag == 0
        if @user_msg.include?("?v=")
          @video_id = @user_msg.split('?v=')[1]
          @video = Yt::Video.new id: @video_id
          Music.create(title: @video.title, vid: @video.id, applicant: @cuser.key)
          @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
        elsif @user_msg[-12] == "/"
          @video_id = @user_msg.last(11)
          @video = Yt::Video.new id: @video_id
          Music.create(title: @video.title, vid: @video.id, applicant: @cuser.key)
          @text = "재생목록에 \n" + @video.title + "\n(이)가 추가되었습니다."
        else
          @text = "잘못된 YouTube 주소를 입력하셨습니다."
        end
      elsif @cuser.flag == 1
        p @cuser.key + "유저가 전광판에 \"" + @user_msg + "\" 메시지 보냄"
        Message.create(body: @user_msg, applicant: @cuser.key, state: 0)

        @text = "전광판으로 \n \"#{@user_msg}\" \n 을(를) 보냈습니다."
      end
    end

    @return_msg = {
      :text => @text
    }
    @return_easter ={
      :text => "뮤직 키친의 개발자들을 소개합니다!\n동국대 노종원!\n아주대 장순호!!\n강원대 서현석!!!\n이화여대 엄서영!!!!"
    }
    @return_msg_chat ={
      :text => @text,
      :message_button => {
        :label => "전광판 보러가기",
        :url => "https://rocky-coast-76546.herokuapp.com/"
        }
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
        message: @return_msg,
        :keyboard => @keyboard_applytext
      }
    elsif @user_msg == "개발자"
      @result = {
        :message => @return_easter,
        :keyboard => @keyboard_init
      }
    elsif @cuser.flag == 1
      @result = {
        :message => @return_msg_chat,
        :keyboard => @keyboard_init
        }
        @cuser.update(flag:0)
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

  def ytLink
    @result = {
      :message => "@return_msg",
      :keyboard => "@keyboard_init"
    }
    render json: @result
  end
  def msg
    @result = {
      :message => "메시지를 받았습니다.",
      :keyboard => "키보드입니다."
    }
    render json: @result
  end
end
