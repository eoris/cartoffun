class CreateCartOfFunOrderItems < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_order_items do |t|
      t.decimal :price, precision: 9, scale: 2, null: false
      t.integer :quantity, null: false
      t.belongs_to :product, polymorphic: true
      t.belongs_to :order, index: true

      t.timestamps null: false
    end
  end
end
