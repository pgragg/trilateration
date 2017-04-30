class Triangulate
	require 'set'
	attr_accessor :beacons

	def initialize(beacon1, beacon2, beacon3)
		@beacons = Set.new([beacon1, beacon2, beacon3])
	end

	def find_point
		point_permutations_score = {}
		poo = generate_points
		poo.each do |point| 
			score = get_score(point, @beacons)
			point_permutations_score[score] = point
		end
		best_point = point_permutations_score.sort[0][1] # sort by lowest score (lowest distance from expected distance from beacon)
		mutate(best_point, point_permutations_score.sort[0][0])
	end

	def mutate(point, last_score, mutation_factor = 1.0)
		return point if mutation_factor <= 0.01
		left_point = [ point[0] - mutation_factor, point[1] ]
		right_point = [ point[0] + mutation_factor, point[1] ]
		up_point = [ point[0], point[1] + mutation_factor ]
		down_point = [ point[0], point[1] - mutation_factor ]
		left = get_score(left_point)
		right = get_score(right_point)
		up = get_score(up_point)
		down = get_score(down_point)
		min_score = [left,right,up,down].min 

		if min_score >= last_score
				mutation_factor = (mutation_factor/2)
				return mutate(point, last_score, mutation_factor)
		else 
			if min_score == left 
				mutate(left_point, min_score)
			elsif min_score == right 
				mutate(right_point,min_score)
			elsif min_score == down
				mutate(down_point,min_score)
			else
				mutate(up_point,min_score)
			end
		end
	end

	private

	def generate_points
		beacon = @beacons.sort_by {|beacon| beacon.distance }[0]
		hypotenuse = beacon.distance
		points = Set.new
		(1..360).each do |degree|
			radians = degree * (Math::PI / 180.0)
			x = Math.cos(radians) * hypotenuse
			y = Math.sin(radians) * hypotenuse
			points << [(beacon.x + x), (beacon.y + y)]
		end
		points
	end

	def distance_between_two_points(point1, point2)
		Math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)
	end

	def get_score(point, beacons = @beacons)
		score = 0
		beacons.each do |beacon|
			expected_distance = beacon.distance 
			real_distance = distance_between_two_points(point, beacon.location)
			score += (expected_distance-real_distance).abs
		end
		score 
	end

end