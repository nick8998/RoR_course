class CarriagePassenger < Carriage

  def initialize(amount_seats)
    @amount_seats = amount_seats
    @holden_seats = 0
    @type = :passenger
  end

  def take_seats
    if @amount_seats > 0
      @amount_seats -= 1 and @holden_seats += 1
    end
  end

  def holden_seats
    @holden_seats
  end

  def free_seats
    @amount_seats    
  end

end