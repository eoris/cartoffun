class CreateCartOfFunCountries < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_countries do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
