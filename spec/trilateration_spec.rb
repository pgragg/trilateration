require 'spec_helper'

RSpec.describe Triangulate do

   it 'finds the overlap between three points' do 
   	expect(Triangulate.new(nil, nil,nil).overlap([[0,5], [3,8], [4,100]])).to eq([4,5])
   	# [0,5], [3,8], [4,100] => [4,5]
   	expect(Triangulate.new(nil, nil,nil).overlap([[0,5], [3,8]])).to eq([3,5])
		# [0,5], [3,8] => [3, 5]
		expect(Triangulate.new(nil, nil,nil).overlap([[0,5], [5,10]])).to eq([5,5])
		# [0,5], [5,10] => [5, 5]
		expect(Triangulate.new(nil, nil,nil).overlap([[0, 5], [6, 10]])).to eq([])
		# [0, 5], [6, 10] => []
   end
   it "finds the midpoint of three beacons" do
    # Calculator.solve(1,1,0)
    beacon1 = Beacon.new([0, 20], 20)
    beacon2 = Beacon.new([20, 0], 20)
    beacon3 = Beacon.new([0,0], 28.28)

    triangulate = Triangulate.new(beacon1, beacon2, beacon3)

    expect(triangulate.find_point).to eq([20,20])
  end
  it "finds the midpoint of three beacons" do
    # Calculator.solve(1,1,0)
    beacon1 = Beacon.new([0, 1], 1)
    beacon2 = Beacon.new([1, 0], 1)
    beacon3 = Beacon.new([-1,0], 1)

    triangulate = Triangulate.new(beacon1, beacon2, beacon3)

    expect(triangulate.find_point).to eq([0,0])
  end
  it "finds the midpoint of three beacons" do
    # Calculator.solve(1,1,0)
    beacon1 = Beacon.new([-20, 10], 21.47)
    beacon2 = Beacon.new([10, 5], 17.49)
    beacon3 = Beacon.new([-5,-10], 26.57)

    triangulate = Triangulate.new(beacon1, beacon2, beacon3)

    expect(triangulate.find_point).to eq([-1,20])
  end
end