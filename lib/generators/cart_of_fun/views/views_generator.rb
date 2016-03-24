class CartOfFun::ViewsGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../app/views/cart_of_fun", __FILE__)

  def copy_views
    directory 'carts', 'app/views/cart_of_fun/carts'
    directory 'checkouts', 'app/views/cart_of_fun/checkouts'
    directory 'orders', 'app/views/cart_of_fun/orders'
  end

  def copy_locale
    copy_file "../../../../config/locales/cart_of_fun.en.yml", "config/locales/cart_of_fun.en.yml"
  end
end
