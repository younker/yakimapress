Yakimapress::Application.routes.draw do

  devise_for :users

  root :to => 'home#home', :as => :home
  root :to => 'home#home', :as => :root
  root :to => 'home#about', :as => :about
  root :to => 'home#faq', :as => :faq

  # Hmmmm, if we have this, we lose the contact paths given to us by the contact engine
  # match '*path' => 'products#by_permalink'

end
