class Route
  include InstanceCounter
  attr_reader :stations
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    self.register_instance
    validate!
  end 

  def valid?
    validate!
    true 
  rescue
    false
  end

  def add_station(station)
    @stations.insert(-2, station)    
  end
  
  def remove_station(station)
    @stations.delete(station) unless [first_station, last_station].include?(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end

  protected

  def validate!
    raise "Enter the first station" if first_station.nil?
    raise "Enter the last station" if last_station.nil?
    raise "Enter the first and last stations" if first_station.nil? and last_station.nil?
  end
end