module ProductsHelper

  def permalink(product, target=nil, args={})
    target ||= product.name.downcase
    link_to target, "/"+product.permalink, args
  end
end
