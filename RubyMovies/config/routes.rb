RubyMovies::Application.routes.draw do

  get "/blocklists", to: "blocklists#index", as: "blocklist"
  delete "/blocklists/:blocked_user", to: "blocklists#destroy", as: "delete_blocklist"
  
  get "quizzes/new"
  get "quizzes/create"
  get "/questions/solve", to: "questions#solve"
  get "questions/quiz", to: "questions#quiz", as: "quiz_start"
  get "questions/quiz/new", to: "questions#new_quiz", as: "quiz_new"
  resources :questions do
    member do 
      post "active"
    end
  end

  get "messages/new/:mid", to: "messages#new", as: "message_respond"
  get "messages/outbox", to: "messages#outbox", as: "outbox_messages"
  get "messages/inbox", to: "messages#index", as: "inbox_messages"
  put "messages/block/:user", to: "messages#block", as: "block_user"
  delete "messages/:id", to: "messages#delete", as: "delete_message"
  resources :messages
  
  get 'search', to: 'films#tagsearch', as: "tag_search"
  get 'searchresult', to: 'films#searchresult', as: "search_result_films"
  get 'tags/:tag', to: 'films#index', as: :tag
  
  delete "comments/destroy/:id", to: "comments#destroy", as: "comments_destroy"

  get "films/top", to: "films#top", as: "films_top"
  post "films/:id/review/:rid", to: "films#review", as: "film_review"
  get "/films/suggested", to: "films#suggested", as: "suggested_films"
  resources :films do
    member do
      post "active"
      delete "rempicture"
    end
  end
  resources :films
  get "users/list", as: "manage_users"
  
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users do 
    member do
      get "promote"
      post "promote"
    end
  end

  resources :films do
    resources :comments
  end

  root to: "films#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
