class CarriageCargo < Carriage

  def initialize(place)
    super
    @type = :cargo
  end

  def take_volume(volume)
    @holden_place += volume if @place != holden_place
    @free_place -= volume if @free_place != 0
  end
  
end