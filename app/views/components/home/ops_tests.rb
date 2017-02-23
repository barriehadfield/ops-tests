class Discounter < Hyperloop::Store

   state discount: 30, scope: :class, reader: true
   state lucky_dip_taken: false, scope: :class, reader: true

  def lucky_dip!
    mutate.discount( state.discount + rand(-5..5) )
    mutate.lucky_dip_taken true
  end

end


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

# class ChangeName < Hyperloop::Operation
#   # param :name, type: String
#   step { puts "the first step"}
# end
