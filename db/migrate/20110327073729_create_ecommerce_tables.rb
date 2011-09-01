class CreateEcommerceTables < ActiveRecord::Migration
  def self.up

    # Products
    create_table :products do |t|
      t.string :name, :null => false
      t.string :permalink, :null => false
      t.text :descr
      t.column :price, :decimal, :precision => 8, :scale => 2, :default => 0
      t.column :sale_price, :decimal, :precision => 8, :scale => 2, :default => 0
      t.text :meta_description
      t.text :meta_keywords
      t.string :tags
      t.integer :shipping_weight
      t.string :press_type, :null => false
      t.timestamps
    end

    # Each product has_many :photos
    create_table :photos do |t|
      t.integer :product_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end

    create_table :carts do |t|
      t.datetime :purchased_at
      t.timestamps
    end

    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity
    end

    # PayPal -- how they let us know when a payment has cleared
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :cart_id
      t.string :status
      t.string :transaction_id
      t.timestamps
    end

  end

  def self.down
    drop_table :products
    drop_table :photos
    drop_table :carts
    drop_table :cart_items
    drop_table :payment_notifications
  end

end

