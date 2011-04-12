module HomeHelper
  def images_for_slideshow(type)
    image_dir = "/images/home/imageshow/#{type}"
    d = "#{Rails.root}/public#{image_dir}"
    if File.directory?(d)
      Dir.entries(d).select{|i| i.match(/\.png/) }.collect{ |i| "#{image_dir}/#{i}" }
    else
      []
    end
  end
end
