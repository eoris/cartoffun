class CreateCartOfFunAddresses < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_addresses do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :address, null: false
      t.integer :zipcode, null: false
      t.string :city, null: false
      t.string :phone, null: false
      t.string :type, null: false
      t.belongs_to :country
      t.belongs_to :order
      t.belongs_to :customer, polymorphic: true

      t.timestamps null: false
    end
  end
end
