class LoadProducts < ActiveRecord::Migration
  @wine_permalink = 'wine-press'
  @cider_permalink = 'american-harvester-cider-mill-apple-press'

  def self.up
    Product.create!(:name => 'Wine Press', :press_type => 'wine', :permalink => @wine_permalink, :descr => self.lorem, :price => 799.99, :meta_description => 'this is the wine press meta desription', :meta_keywords => 'wine,press,wine press,yakima,grapes,get drunk')
    Product.create!(:name => 'American Harvester Cider Press', :press_type => 'cider', :permalink => @cider_permalink, :descr => self.cider_press_descr, :price => 999.99, :meta_description => 'The American Harvester is a double tub, hand operated cider mill apple press.', :meta_keywords => 'cider press, cider mill, american harvester, double tub, apple press, cider, press, mill, cider press, yakima, apples')
  end

  def self.down
    Product.find_by_permalink(@wine_permalink).destroy!
    Product.find_by_permalink(@cider_permalink).destroy!
  end

  def self.cider_press_descr
    summary = "<p>The American Harvester is a double tub, hand operated cider mill. This vintage cider press is designed to incorporate the best features from the many different presses manufactured in the late 1800’s. It is efficiently built, with two tubs, so two people can grind and press the apples at the same time. To make the grinding of the apples smooth, fast and easy, the crank handle includes a 3:1 gear ratio complimented by an 18 lb. flywheel. This press is built to process a large quantity of apples, and depending on the speed and endurance of the operators, you could expect to yield 60 to 80 gallons of cider in a given day.</p>"
    construction = "<p><b>Construction</b>The press frame is 4&#8243; x 4&#8243; laminated wood construction for greater strength and durability. Laminated wood provides maximum strength and prevents the legs from twisting with age. The frame is also cross bolted for structural rigidity. All joints are dadoed for maximum strength. The pressing tubs are 12” tall and 14” in diameter. The staves on the tubs are beveled to increase the flow of cider, and for ease of cleaning. The 1.5” threaded acme screw is made from steel and passes through 3” of thread in the cast iron cross arm. The acme screw is supplied with a cast iron “foot” to distribute pressure on the heavy duty wood pressing plate. The grinder housing is made from cast iron. The grinding cylinder is laminated wood construction with 4 sets of stainless steel teeth embedded into the cylinder. The crank handle, gears, flywheel and bearings are all made from cast iron.</p>"
    specs = "<p><b>Specifications</b><ul><li>22” wide by 46” long by 45” high</li><li>Shipping weight is about 200 lbs.</li></ul></p>"

    [summary, construction, specs].join(' ')
  end

  def self.lorem
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end

end
