class CargoTrain < Train
  @instances = 0
  def initialize(number)
    super
    @type = :cargo 
  end

  def add_carriage(carriage)
    super if carriage.type == :cargo
  end
end