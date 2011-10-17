class AddTitleToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :meta_title, :text
  end

  def self.down
    remove_column :products, :meta_title
  end
end
