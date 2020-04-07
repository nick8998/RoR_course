class Route
  include InstanceCounter

  attr_reader :stations
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = [first_station, last_station]
    self.register_instance
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


end