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

  def play
    data = {code: 2, result: :play}
    Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
    respond_to do |format|
      format.js
    end
  end

  def stop
    data = {code: 2, result: :stop}
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

  def super_musics
    music_ary = Music.ids
    @music = Music.create_by_yt(params[:url], 1)
    respond_to do |format|
      format.js
    end
  end

  def messages
    Message.create(body: params[:body])
    respond_to do |format|
      format.js
    end
  end

  def delete
    music_ary = Music.ids
    @music = Music.find(params[:id])
    @music.delete
    index = music_ary.index(@music.id)
    data = {code: 3, result: @music.as_json, index: index + 1}
    Pusher.trigger('dashboard', 'create', data)
    respond_to do |format|
      format.js
    end
  end

  def show
    @musics = Music.all
  end
end
