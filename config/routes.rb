Rails.application.routes.draw do
  resources :restaurantes
  
  VotaPrato::Application.routes.draw do
    match 'ola' => 'ola_mundo#index', via: 'get'
  end

end
