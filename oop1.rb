class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def list_passenger
    @trains.select {|train| train.type == "passenger"}.each {|train| puts train.number}
  end

  def list_freight
    @trains.select {|train| train.type == "freight"}.each {|train| puts train.number}
  end

  def send_train(train)
    @trains.delete(train)
  end

end

class Route
  attr_reader :stations
  def initialize(first_station, last_station)
    @middle_station_index = 0
    @stations = [first_station, last_station]
  end 

  def add_station(station)
    @middle_station_index += 1
    @stations.insert(@middle_station_index, station)    
  end

  def remove_station(station)
    (@stations[0] == station or @stations[-1] == station ) ? puts("Error") : @stations.delete(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_reader :carriages, :type, :speed

  def initialize(number, type, carriages)
    @number = number
    @type = type #passenger or freight
    @carriages = carriages
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end
  def decrease_speed(value)
    @speed <= value ? @speed = 0 : @speed -= value
  end

  def add_carriage
    @speed == 0 ? @carriages += 1 : puts("Сбросьте скорость до 0")
  end
  def remove_carriage
    @speed == 0 ? @carriages -= 1 : puts("Сбросьте скорость до 0")
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
  end

  def station
    @route.stations[@current_station_index]
  end
  def next_station
    @route.stations[@current_station_index+1]
  end
  def last_station
    @route.stations[@current_station_index-1]
  end

  def drive_forward
    if @current_station_index == @route.stations.size-1
      @current_station_index = -1
      @station = @route.stations[@current_station_index+=1]
    else
      @station = @route.stations[@current_station_index+=1]
    end
  end

  def drive_back
    if @current_station_index == 0
      @current_station_index = @route.stations.size
      @station = @route.stations[@current_station_index-=1]
    else
      @station = @route.stations[@current_station_index-=1]
    end
  end
end
