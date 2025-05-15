Rails.application.routes.draw do
  devise_for :users

  # Authenticated and unauthenticated root paths
  authenticated :user do
    root to: 'categories#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Show templates based on category name or slug
  get '/templates/:category', to: 'templates#index', as: 'category_templates'

  # Template routes + nested customized cards
  resources :templates do
    resources :customized_cards, only: [:new, :create]
  end

  # Standalone show route for viewing finalized customized card
  resources :customized_cards, only: [:show]

  # Categories
  resources :categories, only: [:index, :show]
end
