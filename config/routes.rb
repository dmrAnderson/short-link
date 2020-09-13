Rails.application.routes.draw do
  root "links#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :links, only: %i[create show destroy], param: :short_name
    end
  end

  resources :links, only: %i[index show destroy], param: :short_name
end
