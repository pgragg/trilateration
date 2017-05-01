# trilateration

Trilaterates the position of a person based on a given 3 beacons and distance to those beacons. 

Finds the closest beacon to the person and generates 360 points around that beacon.
Points are of the same distance as the distance between the beacon to the person.
Each point is given a score based on distance to the 3 closest beacons to the person. 

In order to minimize the effect of an individual beacon's inaccuracy: 
The point with the lowest score is recursively adjusted until it has the lowest possible score, 
even if that means venturing outside the range of the first beacon's distance-to-target. 
