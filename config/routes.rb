Yakimapress::Application.routes.draw do

  devise_for :users

  match '/about', :to => 'home#about', :as => :about
  match '/q', :to => 'home#faq', :as => :faq

  root :to => 'home#home', :as => :home
  root :to => 'home#home', :as => :root

  # Hmmmm, if we have this, we lose the contact paths given to us by the contact engine
  # match '*path' => 'products#by_permalink'

end
