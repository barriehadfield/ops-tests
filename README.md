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

## Some bad architecture

Take the simple Component below that displays an initial discount then gives the user the option of taking a once only 'Lucky Dip' which will either increase or decrease their discount.

```ruby
class LuckyDip < React::Component::Base

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

The Component works fine but there are two fundamental problems:

+ Firstly, the amount of the discount state is tied to the Component. This is a problem as we might have other Components on the page which need to also see and interact with the discount. We need a better place to keep application state than in our Components.
+ Our business logic (discounts start at 30% and the lucky dip increases or decreases by 5%) is all wrapped up with our presentational code. This makes our application fragile and difficult to evolve. Our application logic should be separate from our display logic.

We will fix these problems but first implementing a Hyperloop Store to keep our discount state and then implementing a Hyperloop Operation to mutate the discount state.

## Adding a Store

## Adding an Operation
