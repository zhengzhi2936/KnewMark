Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  resources :password_resets
  resources :knowledges do
    member do
      post :rate
    end
    collection do
      get :search
    end
  end

  namespace :account do
    scope 'profile' do
     controller :profile do
       get :password
       put :update_password
     end
   end
  end

  namespace :admin do
    resources :subjects
    resources :knowledges do
      member do
        post :reject
        post :publish
        post :hide
      end
      collection do
        get :search
      end 
    end
  end
end
