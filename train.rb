class Train
  include ManufacturingCompany
  include InstanceCounter
  include Valid

  class << self 
    def find(number)
      @@trains[number]
    end
  end

  attr_reader :route, :number, :type, :carriages

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  @@trains = {}

  def initialize(number)  
    @number = number
    @speed = 0
    @carriages = []
    validate!
    @@trains[number] = self
    self.register_instance
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    station.add_train(self)
  end

  def add_carriage(carriage)
    @carriages << carriage if @speed == 0
  end

  def remove_carriage
    @carriages.pop if @speed == 0
  end

  def drive_forward
    if next_station
      station.send_train(self)
      @current_station_index+=1
      station.add_train(self)
    end
  end

  def drive_back
    if previous_station
      station.send_train(self)
      @current_station_index-=1
      station.add_train(self)
    end
  end


  def station
    @route.stations[@current_station_index]
  end


#Можно было бы спрятать эти методы, но я так полагаю они понадобятся дальше

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed <= value ? @speed = 0 : @speed -= value
  end

  def speed
    @speed
  end  

  def check_carriages(&block)
    i = 0
    while i < @carriages.size
      block.call(@carriages[i])
      i+=1
    end
  end

  protected

  def validate!
    raise "Please, enter the train number" if number.nil?
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end

  private
  #Используем их только внутри класса, для проверки условия пути 
  def next_station
    @route.stations[@current_station_index+1] unless station == route.last_station
  end

  def previous_station
    @route.stations[@current_station_index-1] unless station == route.first_station
  end

end




