class RemoconController < ApplicationController
  def previous
    data = {code: 2, result: :previous}
    Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
    respond_to do |format|
      format.js
    end
  end

  def next
    data = {code: 2, result: :next}
    Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
    respond_to do |format|
      format.js
    end
  end

  def musics
    @music = Music.create_by_yt(params[:url])
    respond_to do |format|
      format.js
    end
  end

  def messages
    Message.create(body: params[:body])
    respond_to do |format|
      format.js
      # {
      #   render
      #   "console.log(\"ds\");
      #   $(\"#messages\").val(\"\");"
      # }
    end
  end

  def delete
    @music = Music.find(params[:id])
    @music.delete
    respond_to do |format|
      format.js
    end
  end

  def show
    @musics = Music.all
  end
end
