class PhotosController < InheritedResources::Base
  def new
    @product = Product.find_by_permalink(params['product_id']) || Product.find_by_id(params['product_id'])
  end

  def create
    @photo = Photo.new(params[:photo])
    @photo.product_id = params[:product_id]
    @photo.save!
    redirect_to :back
  end

  def destroy
    photo = Photo.find_by_id(params[:id])
    photo.destroy
    redirect_to :back
  end

end
