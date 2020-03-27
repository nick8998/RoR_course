class Station
  include InstanceCounter
  include Valid

  class << self
    def all
      @@stations
    end
  end

  @@stations = []
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    self.register_instance
  end

  def list_by_type(type)
    @trains.select { |train| train.type == type }
  end


  def add_train(train)
    @trains << train 
  end

  def show_trains
    @trains.each { |train| puts train.number }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def check_trains(&block)
    i = 0
    while i < @trains.size
      block.call(@trains[i])
      i+=1
    end
  end

  protected

  def validate!
    raise "Please, enter the station name" if name.nil?
    raise "Name must have more than 4 characters" if name.length <= 4 
  end

end