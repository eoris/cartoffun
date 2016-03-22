CartOfFun::Engine.routes.draw do
  resource :cart, only: [:show, :update] do
    post    'add_item'
    delete  'remove_item'
    post    'checkout'
    delete  'clear'
  end

  resources :orders, only: [:index, :show] do
    resource :checkout, only: [:show] do
      get   'addresses'
      patch 'update_addresses'
      get   'delivery'
      patch 'update_delivery'
      get   'payment'
      patch 'update_payment'
      get   'confirm'
      post  'place'
    end
  end
end
