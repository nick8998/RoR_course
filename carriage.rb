class Carriage

  include ManufacturingCompany

  def initialize(place)
    @place = place
    @free_place = place
    @holden_place = 0
  end

  def type
    @type
  end

  def holden_place
    @holden_place
  end

  def free_place
    @free_place    
  end

end