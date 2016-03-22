class CreateCartOfFunCoupons < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_coupons do |t|
      t.integer :code
      t.float :discount

      t.timestamps null: false
    end
  end
end
