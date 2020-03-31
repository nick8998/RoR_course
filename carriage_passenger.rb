class CarriagePassenger < Carriage

  def initialize(place)
    super
    @type = :passenger
  end

  def take_place(place)
    super
  end

end