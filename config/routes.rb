Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Website

  resources :contacts, only: [:new, :create]
  resources :newsletters, only: [:new, :create]
  resources :questions, only: [:new, :create]

  # Application

  resources :classrooms, only: [:index, :show]
  resources :classroom_animations do
    resources :closures, only: [:create], controller: 'classroom_animations/closures'
    resources :openings, only: [:create], controller: 'classroom_animations/openings'
  end

  resources :courses

  resources :children
  namespace :parent do
    resources :classroom_animation_reservations
  end

  namespace :teachers do
    resources :courses
  end

  namespace :administration do
    resources :menus, only: [:index]
    resources :responsible_parents, only: [:index] do
      resources :promotings, only: [:create], controller: 'responsible_parents/promotings'
      resources :demotions, only: [:create], controller: 'responsible_parents/demotions'
    end
    resources :teachers, only: [:index] do
      resources :promotings, only: [:create], controller: 'teachers/promotings'
      resources :demotions, only: [:create], controller: 'teachers/demotions'
    end
    resources :users, only: [:index] do
      patch :impersonate, on: :collection
    end
  end
end
