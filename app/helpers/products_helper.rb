module ProductsHelper

  def permalink(product, target=nil, args={:downcase => true})
    target ||= product.name

    if args[:downcase].present?
      target.downcase if args[:downcase]
      args.delete(:downcase)
    end
    
    link_to target, "/p/"+product.permalink, args
  end

  def press_name(product)
    product.press_type.humanize.split(/\s/).collect!{|w| w.capitalize}.join(' ') + " Press"
  end

end
