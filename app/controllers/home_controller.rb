class HomeController < ApplicationController
  def home
    @wine_press = Product.find_by_permalink('villager-wine-press')
    @cider_press = Product.find_by_permalink('colonial-cider-mill-apple-press')
  end

  def about
  end

  def american_village_institute
  end

  def generate_permalink
    render :text => params[:string].present? ? params[:string].make_url_friendly : nil
  end

end
