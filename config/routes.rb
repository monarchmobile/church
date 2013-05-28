Church::Application.routes.draw do
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, :controllers => { :registrations => "users" }


  mount Ckeditor::Engine => '/ckeditor'

	# mount Ckeditor::Engine => '/ckeditor'
  # match "users/search", :to => "users#search"
  devise_scope :user do  
    match "/users/search" => "users#search" 
    match "/users" => "users#index"
    resources :users
  end
  resources :roles
  resources :users do 
    collection { post :sort }
  end
  resources :profiles
  resources :links
  resources :partials
  resources :categories
  resources :prayers 
  resources :affiliations
  resources :references

  #partials
  match "announcement_partial", :to => "announcements#announcement_partial"
  match "blog_partial", :to => "blogs#blog_partial"
  match "event_partial", :to => "events#event_partial"
  match "prayer_partial", :to => "prayers#prayer_partial"


  # announcements
  match 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'
  resources :announcements do
    collection { post :sort }
  end
  match "announcements/:id/announcement_status", to: "announcements#announcement_status", as: "announcement_status"
  match "announcements/:id/announcement_starts_at", to: "announcements#announcement_starts_at", as: "announcement_starts_at"
  match "announcements/:id/announcement_ends_at", to: "announcements#announcement_ends_at", as: "announcement_ends_at"
  
  # blogs
  resources :blogs do
    resources :comments
    collection { post :sort }
  end
  match 'blogs/:id/blog_status', to: 'blogs#blog_status', as: 'blog_status'
  match "blogs/:id/blog_starts_at", to: "blogs#blog_starts_at", as: "blog_starts_at"
  match "blogs/:id/blog_ends_at", to: "blogs#blog_ends_at", as: "blog_ends_at"
  
  # events
  resources :events do
    collection { post :sort }
  end
  match 'events/:id/event_status', to: 'events#event_status', as: 'event_status'
  match "events/:id/event_starts_at", to: "events#event_starts_at", as: "event_starts_at"
  match "events/:id/event_ends_at", to: "events#event_ends_at", as: "event_ends_at"

  # pages
  resources :pages do
    collection { post :sort }
  end
  match 'pages/:id/status', to: 'pages#status', as: 'status'

  # supermodels
  resources :supermodels do
    collection { post :sort }
  end
  match "supermodels/:id/model_status", :to => "supermodels#model_status", :as => "model_status"

  match 'dashboard', :to => 'static_pages#dashboard'
  
  root :to => "pages#show", :id => 'home'
end
