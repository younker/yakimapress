class HomeController < ApplicationController
  def home
    @wine_press = Product.find_by_permalink('wine-press')
    @cider_press = Product.find_by_permalink('american-harvester-cider-mill-apple-press')
  end

  def about
  end

  def american_village_institute
  end

  def generate_permalink
    render :text => params[:string].present? ? params[:string].make_url_friendly : nil
  end

end
