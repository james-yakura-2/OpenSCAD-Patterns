use </../Patterns/Grid_Pattern.scad>
use </../Patterns/Pattern.scad>

bearing_freedom=1;
bearing_retention=bearing_freedom+.2;
height=9.1;
ceiling=2.4;
adj_height=height-ceiling;
width=height*9;

sled(sled_dimensions=[width,width,height],
hole_separation=2*bearing_retention+.4,
hole_radius=adj_height-bearing_retention*2,
bearing_retention=bearing_retention,
bearing_freedom=bearing_freedom, 
hinge_axis=(height-2)/2, 
hinge_segments=4);

/*union()
{
    hinge_pin(2,100);
    translate([0,20,0])
    hinge_pin(2,100);
}*/

//Constraints:
//bearing_retention+hole_radius+sqrt(2*hole_radius+bearing_retention^2)<sled_height (otherwise, holes protrude through top)
//bearing_freedom<bearing_retention (otherwise, bearings fall out)
//Amount that bearings protrude when loaded: 2*bearing_retention+2*hole_radius-4*bearing_freedom-sqrt(2*hole_radius+bearing_retention)
module sled(sled_dimensions, hole_separation, hole_radius, bearing_retention, bearing_freedom,hinge_axis, hinge_segments)
{
    bearing_spacing=hole_separation+hole_radius*2;
    bearing_locations=bearing_pattern(sled_dimensions, bearing_spacing);
    well_offset=sqrt(2*hole_radius+bearing_retention*bearing_retention);
    well_radius=bearing_retention+hole_radius;
    
    union()
    {
        sled_body(sled_dimensions, bearing_locations, well_radius, well_offset, hinge_axis, hinge_segments);
    }
    translate([0,0,well_offset]){
    pattern(bearing_locations)
    {
        bearing(well_radius-bearing_freedom, 0);
    }
    }
}

module sled_body(sled_dimensions, bearing_locations, well_radius, well_offset, hinge_axis, hinge_segments)
{
    difference()
    {
        translate([0,0,sled_dimensions[2]/2])
        union()
        {
        cube(sled_dimensions,true);
            for(x=[0:1:3]) rotate ([0,0,90*x])
        hinge(sled_dimensions[2], sled_dimensions[0], hinge_axis, hinge_segments);
        }
        bearing_wells(bearing_locations, well_radius, well_offset);
    }
}

module bearing_wells(bearing_locations, well_radius, well_offset)
{
    translate([0,0,well_offset])
    {
        pattern(bearing_locations)
        {
            $fn=25;
            sphere(well_radius);
        }
    }
}

module bearing(radius, recursion_depth)
{
    $fn=25;
    sphere(radius);
    //Apply fractalization to surface.
}
module hinge(height, width, hole_radius, segments)
{
    translate([0, -(width+height)/2, 0])
    difference()
    {
        union()
        {
            rotate([0,90,0])
                cylinder(r1=height/2, r2=height/2, h=width, center=true);
            translate([0,(height*1.001)/4,0])
                cube([width*0.999, (height*1.001)/2, height], center=true);
        }
        rotate([0,90,0])
        cylinder(r1=hole_radius, r2=hole_radius, h=width*1.001, center=true);
        translate(-[width/(segments*4),0,0])
        pattern
        (
        volume([width,1,1],[width/segments,1,1])
        )
            cube([width/(segments*2)+1.1, height+2, height+2],center=true);
    }
}
function bearing_pattern(sled_dimensions, bearing_spacing)=volume([sled_dimensions[0],sled_dimensions[1],1], [bearing_spacing, bearing_spacing,1]);

module hinge_pin(radius, height)
{
    union()
    {
        cylinder(r1=radius, r2=radius, h=height-radius*2, center=true);
        translate([0,0,(height-radius)/2])
        sphere(r=radius, center=true);
    }
    translate([0,0,-(height-radius)/2])
    {
        sphere(r=radius, center=true);
    }
}