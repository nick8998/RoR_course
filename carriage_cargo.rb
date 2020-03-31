class CarriageCargo < Carriage

  def initialize(place)
    super
    @type = :cargo
  end

  def take_place(place)
    super
  end
  
end