class Triangulate
	require 'set'
	attr_accessor :beacons

	def initialize(beacon1, beacon2, beacon3)
		@beacons = Set.new([beacon1, beacon2, beacon3])
	end

	def find_point
		point_permutations_score = {}
		poo = get_points_of_overlap
		point_permutations = get_point_permutations(poo)
		point_permutations.each do |point| 
			score = get_score(point, @beacons)
			point_permutations_score[score] = point
		end
		byebug
		point_permutations_score.sort[0][1] # sort by lowest score (lowest distance from expected distance from beacon)
	end

	def overlap(ranges)
		lowest = nil
		highest = nil
		Array(ranges).each do |range|
			lowest ||= range[0]
			lowest = range[0] if range[0] >= lowest 
			highest ||= range[1]
			highest = range[1] if range[1] <= highest
		end
		return [] unless highest >= lowest 
		[lowest, highest]
	end

	private

	def distance_between_two_points(point1, point2)
		Math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)
	end

	def get_score(point, beacons)
		score = 0
		beacons.each do |beacon|
			expected_distance = beacon.distance 
			real_distance = distance_between_two_points(point, beacon.location)
			score += (expected_distance-real_distance).abs
		end
		score 
	end

	def get_point_permutations(poo)
		output = []
		poo[0].each do |x_value|
			poo[1].each do |y_value|
				output << [x_value, y_value]
			end
		end
		output 
	end

	def get_points_of_overlap 
		x = overlap(@beacons.map{|b| b.range(:x)})
		y = overlap(@beacons.map{|b| b.range(:y)})
		[x,y]
	end

end

class Calculator 

# require 'nmatrix'
# coeffs = NMatrix.new([3,3],
# [1, 1,-1,
# 1,-2, 3,
# 2, 3, 1], dtype: :float32)

# rhs = NMatrix.new([3,1],
# [4,
# -6,
# 7], dtype: :float32)

# solution = coeffs.solve(rhs)
# #=> [1.0, 2.0, -1.0]

	def self.solve(a,b,c)
		[quad_pos(a,b,c), quad_neg(a,b,c)]
	end

	def self.sqr(a)
	  a * a
	end

	def self.quad_pos(a, b, c)
	  (-b + (Math.sqrt( sqr(b) - 4*a*c ))) / 2*a
	end

	def self.quad_neg(a, b, c)
	  (-b - (Math.sqrt( sqr(b) - 4*a*c ))) / 2*a
	end

end