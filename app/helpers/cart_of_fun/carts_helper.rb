module CartOfFun
  module CartsHelper
    def find_order_item(product)
      product.split('_').first.constantize.find_by_id(product[/\d+/])
    end

    def order_item_price(qty, product)
      qty * find_order_item(product).price
    end

    def total_items_quantity
      session[:cart].each_value.reduce(:+)
    end

    def cart_count
      session[:cart].blank? ? "EMPTY" : total_items_quantity
    end
  end
end
