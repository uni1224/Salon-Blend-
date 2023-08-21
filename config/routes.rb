Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end
  get 'searches/search'

  scope module: :user do
    root to: 'homes#top'
    post 'like/:id' => 'likes#create', as: 'create_like'
    delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
    get 'users/about' => 'homes#about', as: 'about'
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/quit' => 'users#quit', as: 'confirm_quit'
    put 'users/information' => 'users#update'
    patch 'users/out' => 'users#out', as: 'out_user'
    resources :reservations
    resources :rooms, only: %i[index show]
    resource :message, only: :create
    resources :posts, only: %i[index show] do
      resources :comments, only: %i[create destroy]
    end
  end
  # サロン用
  devise_for :salons, skip: [:passwords], controllers: {
    registrations: 'salon/registrations',
    sessions: 'salon/sessions'
  }

  namespace :salon do
    root to: 'homes#top'
    get 'users/:user_id/resarvations' => 'resarvations#index', as: 'user_resarvations'
    get 'salons/mypage' => 'salons#show', as: 'mypage'
    get 'salons/information/edit' => 'salons#edit', as: 'edit_information'
    patch 'salons/information' => 'salons#update', as: 'update_information'
    get 'salons/quit' => 'salons#quit', as: 'confirm_quit'
    put 'salons/information' => 'salons#update'
    patch 'salons/out' => 'salons#out', as: 'out_salon'
    resources :posts, only: %i[index show new create edit update destroy]
    resources :comments, only: %i[index show destroy]
    resources :reservations do
      patch 'update_status', on: :member
    end
    resources :users, only: %i[show index edit update]
    resources :rooms, only: %i[index show]
    resource :message, only: :create
  end
end
