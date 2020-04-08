class Carriage

  include ManufacturingCompany
  
  
  def initialize(place)
    @place = place
    @holden_place = 0
  end

  def type
    @type
  end

  def take_place(place)
    @holden_place += place if @place != @holden_place
  end

  def holden_place
    @holden_place
  end

  def free_place
    @place - @holden_place    
  end

end