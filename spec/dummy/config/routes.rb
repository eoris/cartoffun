Rails.application.routes.draw do

  mount CartOfFun::Engine => "/"
  resources :books, only: :index
  resources :puzzles, only: :index
end
