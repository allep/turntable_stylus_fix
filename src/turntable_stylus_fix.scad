// Fix for a Pioneer turntable stylus
// Author: Alessandro Paganelli (alessandro.paganelli@gmail.com)

// Measures: in mm

// Constants
$fn = 50;

// Radius + approx 1% tolerance
HOLE_RADIUS = 1.3;
THICKNESS = 3.5;
SEPARATION = 10.1;
SIZE_X = 14.0;
SIZE_Y = 19.0;
WALL_X = 5.0;
WALL_Y = 2.0;
WALL_Z = 3.5;

// Modules
module fix_wall(wall_x, wall_y, wall_z)
{
    cube([wall_x, wall_y, wall_z], center = true);
}


module fix_base(size_x, size_y, thickness)
{
    hull_radius = 1.0;
    minkowski()
    {
        cube([size_x - 2 * hull_radius, size_y - 2 * hull_radius, thickness / 2], center = true);
        cylinder(r = 1, h = thickness / 2, center = true);
    }
}

module screw_holes(radius, distance_y, hole_height)
{
    actual_distance_y = distance_y + 2 * radius;
    union()
    {
        translate([0, actual_distance_y / 2, 0])
        cylinder(h = hole_height, r = radius, center = true);
        
        translate([0, - actual_distance_y / 2, 0])
        cylinder(h = hole_height, r = radius, center = true);
    }
}


// Actual script
difference()
{
    union()
    {
        fix_base(SIZE_X, SIZE_Y, THICKNESS);
        translate([SIZE_X / 2 - WALL_X / 2, SEPARATION / 2, THICKNESS])
        fix_wall(WALL_X, WALL_Y, WALL_Z);
        translate([SIZE_X / 2 - WALL_X / 2, - SEPARATION / 2, THICKNESS])
        fix_wall(WALL_X, WALL_Y, WALL_Z);
    }
    screw_holes(HOLE_RADIUS, SEPARATION, THICKNESS);
}