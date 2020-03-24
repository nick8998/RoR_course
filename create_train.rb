require_relative 'instance_counter.rb'
require_relative 'manufacturing_company.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_passenger.rb'




@trains = []
attempt = 0
begin
  puts "1, если поезд пассажирский"
  puts "2, если поезд грузовой"
  puts "0, если выйти"
  next_act = gets.chomp.to_i
  case next_act
  when 1
  puts "Введите номер поезда: "
  number = gets.chomp
  @trains << PassengerTrain.new(number)
  puts "Создан пассажирский поезд с номером: #{number}"
  when 2
  puts "Введите номер поезда: "
  number = gets.chomp
  @trains << CargoTrain.new(number) 
  puts "Создан грузовой поезд с номером: #{number}"
else
  nil
end
rescue RuntimeError => e
  puts "Number has invalid format"
  attempt += 1
  retry if attempt < 3
end
