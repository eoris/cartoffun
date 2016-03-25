## CartOfFun

### Installation:
Add this line to your application's Gemfile:

```ruby
  gem 'cart_of_fun', git: 'https://github.com/eoris/cartoffun'
```

And then execute:
```
  $ bundle
```

Run the [Simple Form](https://github.com/plataformatec/simple_form) generators:
```
  rails generate simple_form:install
  rails generate simple_form:install --bootstrap
```

## Usage:

### Initialization

##### Your 'Product' models should contain next fields:
  - title
  - description
  - price

##### After installation, you need to run the rake tasks:
```
  rake cart_of_fun:inslall:migration
  rake db:migrate
  rake cart_of_fun:load_seed
```

##### Add to your config/routes.rb:
```ruby
  mount CartOfFun::Engine => "/cartoffun"
```

##### Add to your product models:
```ruby
class Book < ActiveRecord::Base
  ...
  acts_as_product
end
```

```ruby
class Puzzle < ActiveRecord::Base
  ...
  acts_as_product
end
```

##### Add to your user models:
```ruby
class User < ActiveRecord::Base
  ...
  acts_as_customer
end
```

Add a :current_user method, unless you are using the [Devise](https://github.com/plataformatec/devise) gem
```ruby
  class ApplicationController < ActionController::Base
    ...
    def current_customer
      @user
    end
  end
```

##### View helpers
forms for adding book to cart
```ruby
  <%= form_for :product, url: cart_of_fun.add_item_cart_path, method: :post do |f| %>
    <%= number_to_currency @book.price %>
    <%= f.number_field :quantity, value: 1, min: 1, max: 9 %>
    <%= f.hidden_field :product_id, value: "#{@book.class}_#{@book.id}" %>
    <%= f.submit t('cart_of_fun.cart.add_to_cart')%>
  <% end %>
```

or puzzle
```ruby
  <%= form_for :product, url: cart_of_fun.add_item_cart_path, method: :post do |f| %>
    <%= number_to_currency @puzzle.price %>
    <%= f.number_field :quantity, value: 1, min: 1, max: 9 %>
    <%= f.hidden_field :product_id, value: "#{@puzzle.class}_#{@puzzle.id}" %>
    <%= f.submit t('cart_of_fun.cart.add_to_cart')%>
  <% end %>
```

link to the cart:
```ruby
  <%= link_to 'Cart', cart_of_fun.cart_path %>
```

link to the orders history:
```ruby
  <%= link_to 'Orders', cart_of_fun.orders_path %>
```

##### Customization
If you want to customize views
```ruby
  rails generate cart_of_fun:views
```
or controllers
```ruby
  rails generate cart_of_fun:controllers
```
