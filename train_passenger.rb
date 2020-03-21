class PassengerTrain < Train
  @instances = 0
  def initialize(number)
    super
    @type = :passenger
  end

  def add_carriage(carriage)
    super if carriage.type == :passenger
  end
end