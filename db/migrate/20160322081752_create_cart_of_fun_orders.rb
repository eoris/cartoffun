class CreateCartOfFunOrders < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_orders do |t|
      t.decimal :total_price, precision: 9, scale: 2, null: false
      t.datetime :completed_date, null: false
      t.belongs_to :customer, polymorphic: true
      t.belongs_to :delivery
      t.string :state

      t.timestamps null: false
    end
  end
end
