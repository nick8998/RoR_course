require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_passenger.rb'
require_relative 'train_cargo.rb'
require_relative 'route.rb'
require_relative 'carriage.rb'
require_relative 'carriage_cargo.rb'
require_relative 'carriage_passenger.rb'

class RailRoad
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def seed
    t1 = CargoTrain.new(1)
    t2 = CargoTrain.new(2)
    t3 = PassengerTrain.new(3)
    t4 = PassengerTrain.new(4)
    t5 = PassengerTrain.new(5)



    st1 = Station.new("st1")
    st2 = Station.new("st2")
    st3 = Station.new("st3")
    st4 = Station.new("st4")
    st5 = Station.new("st5")

    r1 = Route.new(st1, st5)
    r1.add_station(st2)
    r1.add_station(st3)
    r1.show_stations
    t1.add_route(r1)
    t1.station
  end

  def menu
    puts "Введите 1, чтобы создать поезд, станцию, маршрут или вагон"
    puts "Введите 2, чтобы произвести операцию над объектом"
    puts "Введите 3, чтобы увидеть информацию об объектах"
    puts "Введите 0, чтобы завершить программу"

    next_action = gets.chomp.to_i

    case next_action

    when 1
      creating_obj

    when 2
      changing_obj

    when 3
      show_info

    else
      nil
    end
  end

  def creating_obj
    puts "Введите 1, чтобы создать станцию"
    puts "Введите 2, чтобы создать поезд"
    puts "Введите 3, чтобы создать маршрут"
    puts "Введите 4, чтобы создать вагон"
    puts "Введите 0, чтобы вернуться назад"

    next_action = gets.chomp.to_i

    case next_action

    when 1
      creating_station
      creating_obj
    when 2
      puts "Введите 1, если поезд пассажирский"
      puts "Введите 2, если поезд грузовой"
      puts "Введите 0, чтобы вернуться назад"
      add_train
      creating_obj

    when 3
      creating_route
      creating_obj

    when 4
      puts "Введите 1, если вагон пассажирский"
      puts "Введите 2, если вагон грузовой"
      puts "Введите 0, чтобы вернуться назад"
      add_carriage
    else
      menu
    end
  end

  def changing_obj
    puts "Введите 1, чтобы изменить станции в маршруте"
    puts "Введите 2, чтобы назначить маршрут поезду"
    puts "Введите 3, чтобы изменить кол-во вагонов в поезде"
    puts "Введите 4, чтобы поезд поехал"
    puts "Введите 0, вернуться назад"

    next_action = gets.chomp.to_i

    case next_action

    when 1
      puts "Введите 1, чтобы добавить станцию в маршрут"
      puts "Введите 2, чтобы удалить станцию из маршрута"
      puts "Введите 0, чтобы вернуться назад"
      add_station_to_route

    when 2
      route_for_train
      changing_obj

    when 3
      puts "Введите 1, чтобы добавить вагон в поезд"
      puts "Введите 2, чтобы удалить вагон из поезда"
      puts "Введите 0, чтобы вернуться назад"
      adding_carriage_to_train

    when 4
      puts "Введите 1, чтобы поезд поехал вперед"
      puts "Введите 2, чтобы поезд поехал обратно"
      puts "Введите 0, чтобы вернуться назад"
      move_train

    else
      menu
    end
  end

  def show_info
    puts "Введите 1, чтобы вывести список станций в маршруте"
    puts "Введите 2, чтобы вывести список поездов на станции"
    puts "Введите 0, чтобы вернуться назад"

    next_action = gets.chomp.to_i

    case next_action
    when 1
      puts "Введите номер маршрута: "
      route_number = gets.chomp.to_i - 1
      @routes[route_number].show_stations
      show_info
    when 2
      puts "Введите название станции"
      station_name = gets.chomp
      station_index = @stations.index { |station| station.name == station_name }
      @stations[station_index].show_trains
      show_info
    else
      menu
    end
  end

  def creating_station
    puts "Введите название станции: "
    name = gets.chomp
    @stations << Station.new(name)
  end

  def creating_passenger_train
    puts "Введите номер поезда: "
    number = gets.chomp
    @trains << PassengerTrain.new(number)
  end

  def creating_cargo_train
    puts "Введите номер поезда: "
    number = gets.chomp
    @trains << CargoTrain.new(number)
  end

  def creating_route
    puts "Введите номер маршрута (начиная с 1): "
    route_number = gets.chomp.to_i - 1
    puts "Введите начальную станцию: "
    first_station_name = gets.chomp
    puts "Введите конечную станцию: "
    last_station_name = gets.chomp
    first_station = @stations.index { |station| station.name == first_station_name }
    last_station = @stations.index { |station| station.name == last_station_name }
    @routes[route_number] = Route.new(@stations[first_station], @stations[last_station])
  end

  def adding_station_to_route
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    puts "Введите название станции: "
    station_name = gets.chomp
    station_index = @stations.index { |station| station.name == station_name }
    @routes[route_number].add_station(@stations[station_index])
  end

  def removing_station_from_route
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    puts "Введите название станции: "
    station_name = gets.chomp
    station_index = @stations.index { |station| station.name == station_name }
    @routes[route_number].remove_station(@stations[station_index])
  end

  def route_for_train
    puts "Введите номер поезда: "
    train_number = gets.chomp
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].add_route(@routes[route_number])
  end

  def adding_carriage
    puts "Введите номер поезда: "
    train_number = gets.chomp
    puts "Введите номер вагона: "
    carriage_index = gets.chomp.to_i - 1
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].add_carriage(@carriages[carriage_index])
  end

  def removing_carriage
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].remove_carriage
  end

  def driving_forward
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_number = @trains.index { |train| train.number == train_number }
    @trains[train_number].drive_forward    
  end

  def driving_back
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_number = @trains.index { |train| train.number == train_number }
    @trains[train_number].drive_back
  end

  def add_carriage
    next_action = gets.chomp.to_i
    case next_action
    when 1
      @carriages << CarriagePassenger.new
      creating_obj
    when 2
      @carriages << CarriageCargo.new
      creating_obj
    else
      creating_obj
    end     
  end

  def add_train
    next_action = gets.chomp.to_i
    case next_action
    when 1
      creating_passenger_train
      creating_obj
    when 2
      creating_cargo_train
      creating_obj
    else
      creating_obj
    end     
  end

  def add_station_to_route 
    next_action = gets.chomp.to_i  
    case next_action
    when 1
      adding_station_to_route
      changing_obj
    when 2
      removing_station_from_route
      changing_obj
    else
      changing_obj
    end
  end

  def adding_carriage_to_train
    next_action = gets.chomp.to_i
    case next_action
    when 1 
      adding_carriage
      changing_obj
    when 2
      removing_carriage
      changing_obj
    else 
      changing_obj
    end
  end

  def move_train
    next_action = gets.chomp.to_i
    case next_action
    when 1 
      driving_forward
      changing_obj
    when 2
      deriving_back
      changing_obj
    else
      changing_obj
    end
  end



end

