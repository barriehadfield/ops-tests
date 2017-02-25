class Bumber < Hyperloop::Operation
end


class Discounter < Hyperloop::Store
   state discount: 30, scope: :class, reader: true
   state lucky_dip_taken: false, scope: :class, reader: true

  def self.lucky_dip!
    mutate.discount( state.discount + rand(-5..5) )
    mutate.lucky_dip_taken true
  end

  receives Bumper do
    mutate.discount( state.discount * 10 )
  end
end


class OfferLuckyDip < React::Component::Base
  def render
    DIV do
      H1 {"Your discount is #{Discounter.discount}%"}
      BUTTON { "Lucky Dip" }.on(:click) do
        Discounter.lucky_dip!
      end unless Discounter.lucky_dip_taken
    end
    BUTTON { "Bump" }.on(:click) do
      # Hyperloop::Operation::Bumper()
      Bumper.run
    end
  end
end
