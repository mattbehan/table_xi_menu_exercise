Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  post "home/upload" => "home#upload"
end
