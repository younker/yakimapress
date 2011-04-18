class ConvertToPaymentHandler < ActiveRecord::Migration
  def self.up
    create_table :payment_handlers do |t|
      t.text :params
      t.integer :cart_id
      t.string :status
      t.string :transaction_id
      t.timestamps
    end
    drop_table :payment_notifications
  end

  def self.down
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :cart_id
      t.string :status
      t.string :transaction_id
      t.timestamps
    end
    drop_table :payment_handlers
  end
end
