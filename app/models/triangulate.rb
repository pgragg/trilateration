class Triangulate
	require 'set'
	attr_accessor :beacons

	def initialize(beacon1, beacon2, beacon3, opts={})
		@beacons = Set.new([beacon1, beacon2, beacon3])
	end

	def find_point
		point_permutations_score = {}
		closest_beacon = @beacons.sort_by {|beacon| beacon.distance }[0]
		best_point_location = closest_beacon.location
		mutate(best_point_location)
	end

	def mutate(point, last_score = nil, mutation_factor = 1)
		last_score ||= get_score(point)
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

# # this method is slow, but accomplishes the same thing as the above. 
# def generate_points_in_circular_method
# 	poo = generate_points
# 	poo.each do |point| 
# 		score = get_score(point, @beacons)
# 		point_permutations_score[score] = point
# 	end
# 	best_point = point_permutations_score.sort[0] # sort by lowest score (lowest distance from expected distance from beacon)
# 	score = point_permutations_score.sort[0][0]
# 	best_point_location = point_permutations_score.sort[0][1]
# end

# def generate_points
# 	beacon = @beacons.sort_by {|beacon| beacon.distance }[0]
# 	hypotenuse = beacon.distance
# 	points = Set.new
# 	(1..22).each do |degree|
# 		radians = degree * 16.363636 *  (Math::PI / 180.0)
# 		x = Math.cos(radians) * hypotenuse
# 		y = Math.sin(radians) * hypotenuse
# 		points << [(beacon.x + x), (beacon.y + y)]
# 	end
# 	points
# end
