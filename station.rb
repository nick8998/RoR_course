class Station
  include InstanceCounter
  include Validation

  class << self
    def all
      @@stations
    end
  end

  @@stations = []

  attr_reader :name, :trains

  validate :name, :presence


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

  def check_trains
    @trains.each { |train| yield train }
  end

end