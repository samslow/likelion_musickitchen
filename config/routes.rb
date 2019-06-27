Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/keyboard' => 'kakao#keyboard'
  post '/message' => 'kakao#message'
  post '/ytLink' => 'kakao#ytLink'
  post '/msg' => 'kakao#msg'
  get 'remocon' => "remocon#show"

  get 'remocon/delete_list/:id' => "remocon#delete"
  get 'remocon/previous' => "remocon#previous"
  get 'remocon/next' => "remocon#next"
  get 'remocon/play' => "remocon#play"
  get 'remocon/stop' => "remocon#stop"

  post 'remocon/musics'
  post 'remocon/super_musics'
  post 'remocon/messages'

  root 'kakao#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
