class CartOfFun::ControllersGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../../app/controllers", __FILE__)

  def copy_controllers
    directory 'cart_of_fun', 'app/controllers/cart_of_fun'
  end
end
