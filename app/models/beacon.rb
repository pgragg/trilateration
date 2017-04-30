class Beacon
	attr_accessor :x, :y, :distance
	def initialize(point, distance = 0)
		@x = point[0]
		@y = point[1]
		@distance = distance
	end

	def range(coord)
		[min(coord),max(coord)]
	end

	def max(coord)
		send(coord.to_sym) + @distance.abs
	end

	def min(coord)
		send(coord.to_sym) - @distance.abs
	end

	def location
		[@x, @y]
	end
end



# def circle_formula

# # (x-3)^2 + (y+1)^2 = 25 
# # for [3,-1] and distance 5 
# end