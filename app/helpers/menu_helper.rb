module MenuHelper
  def menu_items
    [
      {:url => home_path, :name => 'Home', :descr => 'Main Page'},
      {:url => about_path, :name => 'About', :descr => 'Who We Are'},
      {:url => products_path, :name => 'Shop', :descr => 'Our Products'},
      {:spacer => true},
      {:url => '/blog', :name => 'Blog', :descr => 'Articles & Info'},
      {:url => faqs_path, :name => 'FAQ', :descr => 'Learn More'},
      {:url => contact_path, :name => 'Contact', :descr => 'Get In Touch', :klass => 'last'},
    ]
  end
end