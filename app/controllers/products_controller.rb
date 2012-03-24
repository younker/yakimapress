class ProductsController < InheritedResources::Base
  before_filter :redirect_if_verbose_path, :only => [:show]
  before_filter :redirect_unless_admin, :except => [:index, :search, :by_permalink]

  before_filter :set_product, :except => [:index, :new, :create, :search]
  before_filter :set_canonical, :except => [:index, :search, :create, :edit, :update, :destroy]


  def index
    @wine_press = Product.find_by_permalink('villager-wine-press')
    @cider_press = Product.find_by_permalink('colonial-cider-mill-apple-press')
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
      
  # Route catch-all for pages like /villager-wine-press

  def by_permalink
    if @product.present?
      render :template => 'products/show'
    else
      render :template => 'public/404.html', :status => '404'
    end
  end


  private 

  def redirect_if_verbose_path
    if request.env['PATH_INFO'].match(/^\/products\/\w.*$/)
      terse_path = request.env['PATH_INFO'].gsub(/\/products\//,'/p/')
      redirect_to(terse_path, :status => 301)
    end
  end

  def set_product
    tmp = params['id'].present? ? params['id'] : params['path']
    @product = Product.find_by_permalink(tmp) || Product.find_by_id(tmp)
    redirect_to(products_path, :status => 301) unless @product.present?
  end

  def set_canonical
    @canonical = product_url(@product.permalink) unless product_path(@product.permalink) == request.path
  end

end
