namespace :cart_of_fun do
  task :load_seed => :environment do
    CartOfFun::Engine.load_seed
    puts 'Countries and Deliveries loaded'
  end
end
