## Baseline

+ `rails new App`
+ `rails g controller Home`
+ `gem 'hyper-rails'`
+ `bundle`
+ `rails g hyperloop:install --all`
+ `bundle update`

## Setup

+ `gem 'hyper-store', git: 'https://github.com/ruby-hyperloop/hyper-store.git'`
+ `gem 'hyper-operation', git: 'https://github.com/ruby-hyperloop/hyper-operation.git'`
+ add `require 'hyper-operation'` to components.rb
+ add `mount Hyperloop::Engine => "/hyperloop_engine"` to routes.rb

## A bad Component

Take the simple Component below that displays an initial discount then gives the user the option of taking a once only 'Lucky Dip' which will either increase or decrease their discount.

```ruby
class OfferLuckyDip < React::Component::Base

  define_state discount: 30
  define_state lucky_dip_taken: false

  def render
    div do
      h1 {"Your discount is #{state.discount}%"}
      BUTTON { "Lucky Dip" }.on(:click) do
        state.discount! (state.discount + rand(-5..5))
        state.lucky_dip_taken! true
      end unless state.lucky_dip_taken
    end
  end

end
```

The Component will work as expected but there are two fundamental problems with the architecture:

+ Firstly, the discount (state) is tied to the Component itself. This is a problem as we might have other Components on the page which need to also see and interact with the discount. We need a better place to keep application state than in our Components.
+ Our business logic (discounts start at 30% and the lucky dip increases or decreases by 5%) is all wrapped up with our presentational code. This makes our application fragile and difficult to evolve. Our application logic should be separate from our display logic.

We will fix these problems but first implementing a Hyperloop Store to keep our discount state and then implementing a Hyperloop Operation to mutate the discount state and encapsulate our business logic.

## Adding a Store

Hyperloop Stores (similar to Flux Stores) exist to hold local application state. Components read state from Stores and render accordingly. This separation of concerns is an improvement in the overall architecture and makes our application easier to maintain. 

```ruby
class OfferLuckyDip < React::Component::Base

  before_mount do
    @store = Discounter.new
  end

  def render
    div do
      h1 {"Your discount is #{@store.discount}%"}
      BUTTON { "Lucky Dip" }.on(:click) do
        @store.lucky_dip!
      end unless @store.lucky_dip_taken
    end
  end

end

class Discounter < HyperStore::Base

   state discount: 30
   state lucky_dip_taken: false

   def discount
     state.discount
   end

   def lucky_dip_taken
     state.lucky_dip_taken
   end

  def lucky_dip!
    mutate.discount( state.discount + rand(-5..5) )
    mutate.lucky_dip_taken true
  end

end
```

## Adding an Operation
