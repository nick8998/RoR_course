class CarriagePassenger < Carriage

  def initialize(place)
    super
    @type = :passenger
  end

  def take_seats
    @holden_place += 1 if @place != holden_place
    @free_place -= 1 if @free_place != 0
  end

end