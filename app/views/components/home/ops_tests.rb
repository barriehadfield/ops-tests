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

# class ChangeName < Hyperloop::Operation
#   # param :name, type: String
#   step { puts "the first step"}
# end
