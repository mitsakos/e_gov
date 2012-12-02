#== Route Map
# Generated on 24 Aug 2012 16:15
#
#              log_in GET    /log_in(.:format)                   sessions#new
#             sign_up GET    /sign_up(.:format)                  users#new
#                root        /                                   users#new
#               users GET    /users(.:format)                    users#index
#                     POST   /users(.:format)                    users#create
#            new_user GET    /users/new(.:format)                users#new
#           edit_user GET    /users/:id/edit(.:format)           users#edit
#                user GET    /users/:id(.:format)                users#show
#                     PUT    /users/:id(.:format)                users#update
#                     DELETE /users/:id(.:format)                users#destroy
#            sessions GET    /sessions(.:format)                 sessions#index
#                     POST   /sessions(.:format)                 sessions#create
#         new_session GET    /sessions/new(.:format)             sessions#new
#        edit_session GET    /sessions/:id/edit(.:format)        sessions#edit
#             session GET    /sessions/:id(.:format)             sessions#show
#                     PUT    /sessions/:id(.:format)             sessions#update
#                     DELETE /sessions/:id(.:format)             sessions#destroy
#     password_resets GET    /password_resets(.:format)          password_resets#index
#                     POST   /password_resets(.:format)          password_resets#create
#  new_password_reset GET    /password_resets/new(.:format)      password_resets#new
# edit_password_reset GET    /password_resets/:id/edit(.:format) password_resets#edit
#      password_reset GET    /password_resets/:id(.:format)      password_resets#show
#                     PUT    /password_resets/:id(.:format)      password_resets#update
#                     DELETE /password_resets/:id(.:format)      password_resets#destroy

EGov::Application.routes.draw do

	get "log_out" => "sessions#destroy", :as => "log_out"
	get "log_in" => "sessions#new", :as => "log_in"
	get "sign_up" => "users#new", :as => "sign_up"
	root :to => "posts#index"
	resources :users
	resources :sessions
	resources :password_resets
	resources :posts do
		resources :comments
	end
	resources :forums do
		resources :topics, :except => :index do
			resources :replies, :except => [:index, :show, :new] 
		end
	end
	
end