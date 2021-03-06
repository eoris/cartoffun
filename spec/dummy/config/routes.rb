Rails.application.routes.draw do

  devise_for :users
  mount CartOfFun::Engine => "/cartoffun"
  root 'puzzles#index'
  resources :books, only: [:index, :show]
  resources :puzzles, only: :index
end
