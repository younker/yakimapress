Yakimapress::Application.routes.draw do

  devise_for :users

  resources :faqs

  match '/about', :to => 'home#about', :as => :about
  match '/american-village-institute', :to => 'home#american_village_institute', :as => :american_village_institute

  root :to => 'home#home', :as => :home
  root :to => 'home#home', :as => :root

  match '/generate-permalink', :as => 'generate_permalink', :to => 'home#generate_permalink'


  # Hmmmm, if we have this, we lose the contact paths given to us by the contact engine
  # match '*path' => 'products#by_permalink'

end
