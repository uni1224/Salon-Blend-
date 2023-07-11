Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

scope module: :user do
  root to: "homes#top"
  get "users/about" => "homes#about", as: "about"
  get "users/mypage" => "users#show", as: "mypage"
  get 'users/information/edit' => 'users#edit', as: 'edit_information'
  patch 'users/information' => 'users#update', as: 'update_information'
  get 'users/quit' => 'users#quit', as: 'confirm_quit'
  put 'users/information' => 'users#update'
  patch 'users/out' => 'users#out', as: 'out_user'
  resources :posts, only: [:index, :show]
  resources :menus, only: [:index, :show]
  resources :reservations
end

# サロン用
devise_for :salons,skip: [:passwords], controllers: {
  registrations: "salon/registrations",
  sessions: 'salon/sessions'
}

namespace :salon do
  root to: "homes#top"
  get 'users/:user_id/resarvations' => 'resarvations#index', as: 'user_resarvations'
  get "salons/mypage" =>"salons#show", as: "mypage"
  get 'salons/information/edit' => 'salons#edit', as: 'edit_information'
  patch 'salons/information' => 'salons#update', as: 'update_information'
  get 'salons/quit' => 'salons#quit', as: 'confirm_quit'
  put 'salons/information' => 'salons#update'
  patch 'salons/out' => 'salons#out', as: 'out_salon'
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :menus, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :reservations
  resources :reservations_details, only: [:update]
  resources :users, only: [:show, :index, :edit, :update]
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: "homes#top"
  resources :posts, only: [:index, :show]
  resources :menus, only: [:index, :show]
  #resources :resarvations, only: [:index, :show]
  resources :users, only: [:index, :show, :edit, :update]
  resources :salons, only: [:index, :show, :edit, :update]
end
end
