require 'spec_helper'

RSpec.describe Triangulate do
   it "correctly gives you the score" do 
   	# get_score(point, beacons = @beacons)
   	beacon1 = Beacon.new([-20, 10], 21.47)
    beacon2 = Beacon.new([10, 5], 18.6)
    beacon3 = Beacon.new([-5,-10], 30.265)
    triangulate = Triangulate.new(beacon1, beacon2, beacon3)
    expect(triangulate.send(:get_score, [-1,20])).to be_within(0.01).of(0)
   end
   it "trilaterates the location of a person based on distance to beacons" do
    # Calculator.solve(1,1,0)
    beacon1 = Beacon.new([0, 20], 20)
    beacon2 = Beacon.new([20, 0], 20)
    beacon3 = Beacon.new([0,0], 28.28)
    triangulate = Triangulate.new(beacon1, beacon2, beacon3)
    point = triangulate.find_point
    expect(point[0]).to be_within(0.0075).of(20)
    expect(point[1]).to be_within(0.0075).of(20)
  end
  it "trilaterates the location of a person based on distance to beacons" do
    beacon1 = Beacon.new([0, 1], 1)
    beacon2 = Beacon.new([1, 0], 1)
    beacon3 = Beacon.new([-1,0], 1)
    triangulate = Triangulate.new(beacon1, beacon2, beacon3)
    point = triangulate.find_point
    expect(point[0]).to be_within(0.0075).of(0)
    expect(point[1]).to be_within(0.0075).of(0)
  end
  it "trilaterates the location of a person based on distance to beacons" do
    beacon1 = Beacon.new([-20, 10], 21.47)
    beacon2 = Beacon.new([10, 5], 18.6)
    beacon3 = Beacon.new([-5,-10], 30.265)
    triangulate = Triangulate.new(beacon1, beacon2, beacon3)
    point = triangulate.find_point
    expect(point[0]).to be_within(0.0075).of(-1)
    expect(point[1]).to be_within(0.0075).of(20)
  end
end