class CreateProducts < ActiveRecord::Migration
  def self.up
    # create_table :products do |t|
    #   t.string :name, :null => false
    #   t.text :descr
    #   t.column :price, :decimal, :precision => 8, :scale => 2, :default => 0
    #   t.column :sale_price, :decimal, :precision => 8, :scale => 2, :default => 0
    #   t.string :permalink
    #   t.text :meta_description
    #   t.text :meta_keywords
    #   t.timestamps
    # end
    # self.populate
  end


  def self.down
    # drop_table :products
  end

end

