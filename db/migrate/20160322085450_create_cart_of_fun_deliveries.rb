class CreateCartOfFunDeliveries < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_deliveries do |t|
      t.string :title, null: false
      t.decimal :price, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
