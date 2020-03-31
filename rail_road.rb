class RailRoad
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
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

    when 0
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
    puts "Введите 5, чтобы занять объем или места в вагоне"
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

    when 5
      add_to_carriages
      changing_obj
    else
      menu
    end
  end

  def show_info
    puts "Введите 1, чтобы вывести список станций в маршруте"
    puts "Введите 2, чтобы вывести список поездов на станции"
    puts "Введите 3, чтобы вывести список вагонов у поезда"
    puts "Введите 0, чтобы вернуться назад"

    next_action = gets.chomp.to_i

    case next_action
    when 1
      attempt = 0
      begin
      puts "Введите номер маршрута: "
      route_number = gets.chomp.to_i - 1
      @routes[route_number].show_stations
      rescue
      puts "Такого маршрута не существует"
      attempt += 1
      retry if attempt < 3
      end
      show_info
    when 2
      show_stations_route
      show_info
    when 3
      show_carriages
      show_info
    else
      menu
    end
  end



  def creating_station
    attempt = 0
    begin
      puts "Введите название станции: "
      name = gets.chomp
      @stations << Station.new(name)
    rescue
      puts "Название не соответствует формату"
      attempt += 1
      retry if attempt < 3
    end
  end

  def creating_passenger_train
    attempt = 0
    begin
      puts "Введите номер поезда: "
      number = gets.chomp
      @trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд с номером: #{number}"
    rescue RuntimeError => e
      puts "Номер не соответствует формату"
      attempt += 1
      retry if attempt < 3
    end
  end

  def creating_cargo_train
      attempt = 0
    begin
      puts "Введите номер поезда: "
      number = gets.chomp
      @trains << CargoTrain.new(number)
      puts "Создан грузовой поезд с номером: #{number}"
    rescue RuntimeError => e
      puts "Номер не соответствует формату"
      attempt += 1
      retry if attempt < 3
    end
  end

  def creating_route
    puts "Список существующих станций: "
    @stations.each { |station| puts station.name }
    attempt = 0
    begin
    puts "Введите номер маршрута (начиная с 1): "
    route_number = gets.chomp.to_i - 1
    puts "Введите начальную станцию: "
    first_station_name = gets.chomp
    puts "Введите конечную станцию: "
    last_station_name = gets.chomp
    first_station = @stations.index { |station| station.name == first_station_name }
    last_station = @stations.index { |station| station.name == last_station_name }
    @routes[route_number] = Route.new(@stations[first_station], @stations[last_station])
    rescue
      puts "Неверные данные"
      attempt += 1
      retry if attempt < 3
    end
  end

  def adding_station_to_route
    attempt = 0
    begin
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    puts "Введите название станции: "
    station_name = gets.chomp
    station_index = @stations.index { |station| station.name == station_name }
    @routes[route_number].add_station(@stations[station_index])
    rescue
      puts "Неверные данные"
      attempt += 1
      retry if attempt < 3
    end
  end

  def removing_station_from_route
    attempt = 0
    begin
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    puts "Введите название станции: "
    station_name = gets.chomp
    station_index = @stations.index { |station| station.name == station_name }
    @routes[route_number].remove_station(@stations[station_index])
    rescue
      puts "Неверные данные"
      attempt += 1
      retry if attempt < 3
    end
  end

  def route_for_train
    attempt = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    puts "Введите номер маршрута: "
    route_number = gets.chomp.to_i-1
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].add_route(@routes[route_number])
    rescue
      puts "Неверные данные"
      attempt += 1
      retry if attempt < 3
    end
  end

  def adding_carriage
    attempt = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    puts "Введите номер вагона: "
    carriage_index = gets.chomp.to_i - 1
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].add_carriage(@carriages[carriage_index])
    rescue
      puts "Неверные данные"
      attempt += 1
      retry if attempt < 3
    end
  end

  def removing_carriage
    attempt = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_index = @trains.index { |train| train.number == train_number }
    @trains[train_index].remove_carriage
    rescue
      puts "Такого поезда не существует"
      attempt += 1
      retry if attempt < 3
    end
  end

  def driving_forward
    attempt = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_number = @trains.index { |train| train.number == train_number }
    @trains[train_number].drive_forward
    rescue
      puts "Такого поезда не существует"
      attempt += 1
      retry if attempt < 3
    end    
  end

  def driving_back
    attempt = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train_number = @trains.index { |train| train.number == train_number }
    @trains[train_number].drive_back
    rescue
      puts "Такого поезда не существует"
      attempt += 1
      retry if attempt < 3
    end
  end

  def add_carriage
    next_action = gets.chomp.to_i
    case next_action
    when 1
      puts "Введите кол-во мест"
      seats = gets.chomp.to_i
      @carriages << CarriagePassenger.new(seats)
      creating_obj
    when 2
      puts "Введите объем для вагона"
      volume = gets.chomp.to_i
      @carriages << CarriageCargo.new(volume)
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


  def show_carriages
    attempt = 0
    carriage_number = 0
    begin
    puts "Введите номер поезда: "
    train_number = gets.chomp
    train = Train.find(train_number)
      if train.type == :cargo
          train.check_carriages { |carriage| puts "#{carriage_number+=1} Cargo #{carriage.free_place} #{carriage.holden_place}"}
      elsif train.type == :passenger
          train.check_carriages { |carriage| puts "#{carriage_number+=1} Passenger #{carriage.free_place} #{carriage.holden_place}"}
      end 
    rescue
      puts "Такого поезда не существует"
      attempt += 1
      retry if attempt < 3
    end
  end

  def show_stations_route
    attempt = 0
    begin
      puts "Введите название станции"
      station_name = gets.chomp
      station_index = @stations.index { |station| station.name == station_name }
      station = @stations[station_index]
      station.check_trains { |train| puts "#{train.number} #{train.type} #{train.carriages.size}"}
    rescue
      puts "Такой станции не существует"
      attempt += 1
      retry if attempt < 3
    end
  end

  def add_to_carriages
    puts "Введите номер вагона: "
    carriage_index = gets.chomp.to_i-1
    if @carriages[carriage_index].type == :cargo
      puts "Введите кол-во занимаемого объема: "
      place = gets.chomp.to_i
      @carriages[carriage_index].take_place(place)
    elsif @carriages[carriage_index].type == :passenger
      @carriages[carriage_index].take_place(1)
    end
  end

private

  def seed
    t1 = CargoTrain.new("eee-ee")
    t2 = CargoTrain.new("rrr-rr")
    t3 = PassengerTrain.new("eeeee")
    t4 = PassengerTrain.new("rrrrr")
    t5 = PassengerTrain.new("ttttt")



    st1 = Station.new("palm1")
    st2 = Station.new("palm2")
    st3 = Station.new("palm3")
    st4 = Station.new("palm4")
    st5 = Station.new("palm5")

    r1 = Route.new(st1, st5)
    r1.add_station(st2)
    r1.add_station(st3)
    t1.add_route(r1)
    t2.add_route(r1)
    t3.add_route(r1)

    v1 = CarriageCargo.new(123)
    v2 = CarriagePassenger.new(234)

    t1.add_carriage(v1)
    t3.add_carriage(v2)
    p v1.holden_place
    p v1.free_place
    st1.show_trains

    st1.check_trains {|train|  train.number}

  end
end