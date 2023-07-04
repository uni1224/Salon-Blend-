Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

scope module: :user do
  root to: "homes#top"
  get "users/mypage" => "users#show", as: "mypage"
end

# サロン用
devise_for :salons,skip: [:passwords], controllers: {
  registrations: "salon/registrations",
  sessions: 'salon/sessions'
}

namespace :salons do
  root to: "homes#top"
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: "homes#top"
end
end
