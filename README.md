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

## An overloaded Component

Take the simple Component below that displays an initial discount then gives the user the option of taking a once only 'Lucky Dip' which will either increase or decrease their discount.

```ruby
class OfferLuckyDip < React::Component::Base
  define_state discount: 30
  define_state lucky_dip_taken: false

  def render
    DIV do
      H1 {"Your discount is #{state.discount}%"}
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

We will fix these problems but first implementing a Hyperloop Store to keep our application state and business logic out of our Components.

## Adding a Store

Hyperloop Stores (similar to Flux Stores) exist to hold local application state. Components read state from Stores and render accordingly. This separation of concerns is an improvement in the overall architecture and makes our application easier to maintain.

First lets add the Store:

```ruby
class Discounter < Hyperloop::Store
   state discount: 30, scope: :class, reader: true
   state lucky_dip_taken: false, scope: :class, reader: true

  def self.lucky_dip!
    mutate.discount( state.discount + rand(-5..5) )
    mutate.lucky_dip_taken true
  end
end
```
You will notice a few things in the code above:

+ A Store is a ruby class derived from `Hyperloop::Store`
+ We have added two state variables which are both scoped to be class variables meaning that we will only have one instance of this class
+ Similarly the `lucky_dip!` method is a class method
+ Notice how we use `mutate` to change the value of a state variable.

Next we will refactor our Component to use the Store:

```ruby
class OfferLuckyDip < React::Component::Base
  def render
    DIV do
      H1 {"Your discount is #{Discounter.discount}%"}
      BUTTON { "Lucky Dip" }.on(:click) do
        Discounter.lucky_dip!
      end unless Discounter.lucky_dip_taken
    end
  end
end
```

+ Notice that we do not create an instance of the Discounter class but instead access the class methods of the Store `Discounter.lucky_dip!` so that all Components will be using the same 'class instance' of the Store.
+ `Discounter.discount` is a reader class method that was added to the Store for us by `state discount: 30, scope: :class, reader: true` which saved us a lot of typing!

## Adding an Operation
