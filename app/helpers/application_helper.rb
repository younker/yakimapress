module ApplicationHelper
  # include Ecommerce::ProductsHelper

  # Add some data inside the HTML header; must have corresponding
  # content_for?(:foo) ? yield(:foo) : 'default' inside layout.
  # Defaults -- :title, :keywords, :description
  # Example
  #   header(:title, "Administration Functions")
  def header(name, content)
    case name
    when :title then content_for :header_title do "#{content} - Yakima Press Co." end
    else             content_for name do content end
    end
  end

  # Page title inside the body at the top of the main content section
  # Example:
  #   page_title("Administration Functions")
  def page_title(page_title, klass=nil)
    unless page_title.blank?
      content_for :page_title do
        content_tag(:h1, page_title, :id => 'page_title', :class => klass)
      end
    end
  end

  # http://media.railscasts.com/videos/208_erb_blocks_in_rails_3.mov
  def admin_area(&block)
    content_tag(:div, :class => "admin_area", &block) if user_signed_in? && current_user.admin?
  end

  def admin?
    user_signed_in? && current_user.admin?
  end

  def url_for_ssl(url_cmd, id=nil)
    url = id.nil? ? send(url_cmd, :protocol => 'https') : send(url_cmd.to_s, id, :protocol => 'https')
    url.gsub!(/3333/,'3334') if Rails.env.eql?('development')
    url
  end

  def cap(words)
    s = Array(words).collect do |word|
      if word.frozen?
        "#{word} "
      else
        "<span class='cap'>#{word.first}</span><span class='lc'>#{word[1..-1]}</span> "
      end
    end
    s.join(' ').to_s.html_safe
  end

end