class CreateCartOfFunCreditCards < ActiveRecord::Migration
  def change
    create_table :cart_of_fun_credit_cards do |t|
      t.string :number
      t.string :cvv
      t.string :expiration_month
      t.string :expiration_year
      t.belongs_to :customer, polymorphic: true
      t.belongs_to :order

      t.timestamps null: false
    end
  end
end
