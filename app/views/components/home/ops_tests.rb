module Components
  module Home

    class OpsTests < React::Component::Base

      define_state name: "Sally"

      def render
        div do
          h1 {"Hello #{state.name}"}
          BUTTON { "Test me" }.on(:click) do
            state.name! "Frank"
            # ChangeName.run(name: 'Frank')
          end
        end
      end

    end
  end
end

# class ChangeName < Hyperloop::Operation
#   # param :name, type: String
#   step { puts "the first step"}
# end
