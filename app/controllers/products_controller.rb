class ProductsController < InheritedResources::Base
  before_filter :set_product, :only => [:edit, :update]

  def index
    @wine_press = Product.find_by_permalink('wine-press')
    @cider_press = Product.find_by_permalink('american-harvester-cider-mill-apple-press')
  end

  def search
    # http://railscasts.com/episodes/120-thinking-sphinx with will_paginate
    # @products = Product.search(params[:q], :page => 1, :per_page => 5, :order => :name)

    @products = Product.where('name like ? or tags like ?', "%#{params['q']}%", "%#{params['q']}%").paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html { render :template => 'products/search/index' }
      format.xml  { render :xml => @products }
    end
  end
      
  # Route catch-all for pages like /wine-press
  def by_permalink
    if @product = Product.find_by_permalink(params['path'])
      render :template => 'products/show'
    else
      render :template => 'public/404.html', :status => '404'
    end
  end

  private 

  def set_product
    @product = Product.find_by_permalink(params['id']) || Product.find_by_id(params['id'])
  end
end
