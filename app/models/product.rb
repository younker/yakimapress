class Product < ActiveRecord::Base

  # FIXME -- younker [2011-03-30 00:59]
  # Should either get this out or change it so the cart uses it
  include ActionView::Helpers::NumberHelper
  
  has_many :photos

  VALID_PRESS_TYPES = %w[wine cider]

  attr_accessible :name, :permalink, :descr, :price, :sale_price, :meta_description, :meta_keywords, :meta_title, :tags, :shipping_weight, :press_type

  validates_presence_of :name, :permalink, :press_type

  validate :press_type do
    errors.add(:press_type, ': invalid value given') unless valid_press_type?
  end

  def name
    read_attribute(:name).html_safe
  end

  def valid_press_type?
    VALID_PRESS_TYPES.include?(self.press_type)
  end
  
  def photos?
    self.photos.present?
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
