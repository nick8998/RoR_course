class CarriagePassenger < Carriage

  def initialize(place)
    super
    @type = :passenger
  end

  def take_place(_place)
    super(1)
  end

end