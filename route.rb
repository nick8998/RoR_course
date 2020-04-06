class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
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

  protected

  def validate!
    raise "Введите начальную станцию" if first_station.nil?
    raise "Введите конечную станцию" if last_station.nil?
    raise "Объект не является станцией" if last_station.class != Station or first_station.class != Station
    raise "Конечная и начальная станции должны быть разные" if first_station == last_station
  end
end