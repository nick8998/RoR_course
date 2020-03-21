class Station
  include InstanceCounter
  class << self
    def all
      @@stations
    end
  end
  @instances = 0
  @@stations = []
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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

end