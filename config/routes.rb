Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      post  'add_user', action: :addUser, controller: :users
    end 
  end 
end
