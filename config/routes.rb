Rails.application.routes.draw do
  get '/keyboard' => 'kakao#keyboard'
  post '/message' => 'kakao#message'
  get 'remocon' => "remocon#show"

  get 'remocon/delete_list/:id' => "remocon#delete"
  get 'remocon/previous' => "remocon#previous"
  get 'remocon/next' => "remocon#next"

  post 'remocon/musics'
  post 'remocon/messages'

  root 'kakao#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
