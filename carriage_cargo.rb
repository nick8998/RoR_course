class CarriageCargo < Carriage

  def initialize(volume)
    @volume = volume
    @holden_volume = 0
    @type = :cargo
  end

  def take_volume(volume)
    if volume <= @volume
      @volume -= volume and @holden_volume += volume
    end
    
  end

  def volume
    @holden_volume
  end

  def free_volume
    @volume
  end
end