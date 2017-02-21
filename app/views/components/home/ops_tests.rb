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

# class ChangeName < Hyperloop::Operation
#   # param :name, type: String
#   step { puts "the first step"}
# end
