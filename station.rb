class Station
  include InstanceCounter
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
    @@stations << self
    self.register_instance
    validate!
  end

  def valid?
    validate!
    true 
  rescue
    false
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

  protected

  def validate!
    raise "Please, enter the station name" if name.nil?
    raise "Name must have more than 4 characters" if name.length <= 4 
  end

end