Fasdac::Application.routes.draw do
  root to: "calculator#index"

  resource :calculator,
    only: [:index]

  resource :locale,
    only: [:create]

  namespace :admin do
    root to: "home#index"

    resources :crops,
      except: [:show]

    resources :fertilisers,
      except: [:show]

    resources :regression_coefficients,
      only: [:index, :edit, :update]

    resources :soil_coefficients,
      only: [:index, :edit, :update]

    resources :soil_moistures,
      except: [:show]

    resources :soil_textures,
      except: [:show]
  end

  match 'calculator' => 'calculator#index', :via => :post
  match 'calculator' => 'calculator#index', :via => :get

  match '/definitions' => "pages#definitions", via: :get
  match '/disclaimer' => "pages#disclaimer", via: :get
  match '/theory' => "pages#theory", via: :get
end
