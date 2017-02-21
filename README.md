## Setup
+ `rails new App`
+ `rails g controller Home`
+ `gem 'hyper-rails'`
+ `bundle`
+ `rails g hyperloop:install --all`
+ `bundle update`

+ Is there dependancy on HyperMesh?

+ add `require 'hyper-operation'` to components.rb
+ add `mount Hyperloop::Engine => "/hyperloop_engine"` to routes.rb

## Usage

Let's take this basic Component and refactor it to add an Operation and a Store

```ruby
module Components
  module Home

    class OpsTests < React::Component::Base

      define_state name: "Sally"

      def render
        div do
          h1 {"Hello #{state.name}"}
          BUTTON { "Test me" }.on(:click) do
            state.name! "Frank"
          end
        end
      end

    end
  end
end
```
