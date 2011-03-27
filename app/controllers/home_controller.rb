class HomeController < ApplicationController
  def home
    @wine_press = Product.find_by_permalink('wine-press')
    @cider_press = Product.find_by_permalink('american-harvester-cider-mill-apple-press')
  end

  def about
  end

  def faq
  end
  
end
