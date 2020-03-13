class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train if train.station == train.route.stations[0] or nil
  end

  def list_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end 

  def add_station(station)
    @stations.insert(-2, station)    
  end

  def remove_station(station)
    first_station = @stations[0]
    last_station = @stations[-1]
    [first_station, last_station].include?(station) ? nil : @stations.delete(station) 
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_reader :carriages, :type, :route

  def initialize(number, type, carriages)
    @number = number
    @type = type #passenger or freight
    @carriages = carriages
    @speed = 0
  end

  def speed
    @speed
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed <= value ? @speed = 0 : @speed -= value
  end

  def add_carriage
    @speed == 0 ? @carriages += 1 : nil
  end

  def remove_carriage
    @speed == 0 ? @carriages -= 1 : nil
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    @route.stations[@current_station_index].add_train(self)
  end

  def station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index+1]
  end

  def previous_station
    @route.stations[@current_station_index-1]
  end

  def drive_forward
    if next_station
      @route.stations[@current_station_index].send_train(self)
      @current_station_index+=1
      @route.stations[@current_station_index].add_train(self)
    end
  end

  def drive_back
    if previous_station
      @route.stations[@current_station_index].send_train(self)
      @current_station_index-=1
      @route.stations[@current_station_index].add_train(self)
    end
  end
end
