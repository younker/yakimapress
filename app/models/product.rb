class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :photos
  
  def photos?
    !self.photos.empty?
  end

  def price? ; self.price_exists?(self.price)  ; end
  def pricef ; self.format_price(self.price)   ; end

  def sale?       ; self.price_exists?(self.sale_price)  ; end
  def sale_pricef ; self.format_price(self.sale_price)   ; end

  protected

  def format_price(price)
    number_to_currency(sprintf("%.02f", price))
  end

  def price_exists?(price)
    price.to_f > 0
  end


end
