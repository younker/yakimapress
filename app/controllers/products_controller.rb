class ProductsController < InheritedResources::Base

  def edit
    @product = Product.find_by_permalink(params['id']) || Product.find_by_id(params['id'])
    edit!
  end

  def update
    @product = Product.find_by_permalink(params['id']) || Product.find_by_id(params['id'])
    update!
  end

    
  def by_permalink
    if @product = Product.find_by_permalink(params['path'])
      render :template => 'products/show'
    else
      render_404 and return
    end
  end
end
