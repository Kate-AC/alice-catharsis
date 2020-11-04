# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resource :health, only: :show
    resources :contacts, only: :create
    resources :images, only: :index
    resources :memos, only: %i[index show]
    resources :tags, only: :index

    namespace :v1 do
      get "images/latest" => "images#latest"
    end
  end
end
