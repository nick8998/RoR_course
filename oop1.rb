class Station
	attr_reader :trains, :nameStation

	def initialize(nameStation)
		@nameStation = nameStation
		@trains = []
	end

	def add_train(train)
		@trains << train
	end

	def send_train(train)
		@trains.delete_if{|elem| elem == train}
	end

end

class Route
	attr_reader :allStations
	def initialize(firstStation, lastStation)
		@allStations = []
		@allStations[0] = firstStation
		@allStations[1] = lastStation
		@array_index = 0	
	end	

	def add_station(station)
		@allStations << station
		@array_index += 1
		time_station = @allStations[@array_index]
		@allStations[@array_index] = @allStations[@array_index + 1]
		@allStations[@array_index + 1] = time_station
	end

	def remove_station(station)
		@allStations.delete_if{|elem| elem == station}
	end

	def all_stations
		@allStations.each {|station| puts station.nameStation}
	end
end

class Train
	attr_accessor :speed
	attr_reader :carriages, :station, :last_station, :next_station, :type

	def initialize(number, type, carriages)
		@number = number
		@type = type #passenger or freight
		@carriages = carriages
		@station = ""
		@speed = 0
	end

	def stop 
		@speed = 0
	end

	def change_carriages(add)
		if @speed == 0
			add == "+" ? @carriages+=1 : @carriages-=1
		end
	end

	def add_route(route)
		@route = route.allStations
		@i=0
		@last_station = @route[@i-1].nameStation
		@next_station = @route[@i+1].nameStation
		@station = route.allStations[@i].nameStation	
	end

	def change_station(next_st)
		if @i == @route.size-1 and next_st == "next"
			@i = -1
		elsif @i == 0 and next_st != "next"
			@i = @route.size
		end
		next_st == "next" ? @station = @route[@i+=1].nameStation : 
		@station = @route[@i-=1].nameStation
		@last_station = @route[@i-1].nameStation
		@next_station = @route[@i+1].nameStation
	end

end
