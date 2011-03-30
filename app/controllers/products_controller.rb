class ProductsController < InheritedResources::Base
  before_filter :redirect_unless_admin, :except => [:index, :search, :by_permalink]

  before_filter :set_product, :except => [:index, :new, :create, :search]
  before_filter :set_canonical, :except => [:index, :search, :create, :edit, :update, :destroy]


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
    if @product.present?
      render :template => 'products/show'
    else
      render :template => 'public/404.html', :status => '404'
    end
  end


  private 

  def set_product
    Rails.logger.info("----------------------------- products_controller.rb:38")
    tmp = params['id'].present? ? params['id'] : params['path']
    @product = Product.find_by_permalink(tmp) || Product.find_by_id(tmp)
    Rails.logger.info("----------------------------- products_controller.rb:40 - @product = '#{@product.inspect}'")
  end

  def set_canonical
    Rails.logger.info("----------------------------- products_controller.rb:44 - @product_url = '#{@product_url.inspect}'")
    @canonical = product_url(@product.permalink) unless product_path(@product.permalink) == request.path
  end

end
