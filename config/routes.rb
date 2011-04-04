Yakimapress::Application.routes.draw do

  devise_for :users

  # resources :faqs, :as =>faqs
  match '/frequently-asked-questions', :as => :faq_index, :to => 'faqs#index'
  resources 'f', :as => :faqs, :controller => :faqs


  # TODO -- younker [2011-03-30 10:28]
  # After I migrate all the ecommerce engine stuff in here, use this for seo reasons
  # match 'wine-and-cider-press', :as => :products, :via => :get, :to => 'products#index'
  # resources :products, :except => [:index] do
  #   resources :photos
  # end


  match '/about', :to => 'home#about', :as => :about
  match '/american-village-institute', :to => 'home#american_village_institute', :as => :american_village_institute

  root :to => 'home#home', :as => :home
  root :to => 'home#home', :as => :root

  match '/generate-permalink', :as => 'generate_permalink', :to => 'home#generate_permalink'


  # Hmmmm, if we have this, we lose the contact paths given to us by the contact engine
  # match '*path' => 'products#by_permalink'

end
