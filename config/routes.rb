Rails.application.routes.draw do
  root 'galleries#index'

  resources :galleries do
    resources :photos, except: %i[index]
  end

  devise_for :users
end
