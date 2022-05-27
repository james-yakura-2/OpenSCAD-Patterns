
translate([110,0,0])
difference()
{
    translate([0,0,1])
    cylinder(r1=100, r2=100, h=18);
    
    #parallel_pattern(0,13,3,7)
    cylinder(r1=3,r2=3,h=20);
}

translate([-110,0,0])
union()
{
    translate([0,0,-20])
    cylinder(r1=100,r2=100,h=21);
    
    parallel_pattern(0,7,6,12)
    parallel_pattern(0,4,2,2)
    cylinder(r1=1,r2=1,h=40);
}

function PI()=3.1415926535;

//Creates rings of parallel cylinders. The cylinders are arranged in rings, a certain distance apart. Within any given ring, no two cylinders are closer than a certain distance around the ring.
module parallel_perforation(min_distance, rings, ring_width, hole_separation, hole_length, hole_radius)
{    
    if(min_distance==0)
    {
        cylinder(r1=hole_radius, r2=hole_radius, h=hole_length);
    }
    for(ring=[1:rings-1])
    {
        //Calculate the ring's circumference.
        ring_radius=ring*(hole_radius*2+ring_width)+min_distance;
        circumference=ring_radius*2*3.1415926535;
        holes=ceil(circumference/(hole_radius*2+hole_separation));
        increment=360/holes;
        ring_offset=rands(0,increment,1)[0];
        for(hole=[0:holes-1])
        {
            rotate([0,0,increment*hole+ring_offset])
            translate([ring_radius,0,0])
            cylinder(r1=hole_radius, r2=hole_radius, h=hole_length);
        }
    }
}

module parallel_pattern(inner_radius, rings, circumference_spacing, ring_spacing)
{
    if(inner_radius==0)
    {
        children();
    }
    for(ring=[1:rings])
    {
        ring_radius=inner_radius+ring_spacing*ring;
        ring_circumference=PI()*2*ring_radius;
        items=floor(ring_radius/circumference_spacing);
        increment=360/items;
        ring_offset=rands(0,increment,1)[0];
        for(item=[0:items])
        {
            rotate([0,0,item*increment+ring_offset])
            translate([ring_radius,0,0])
            children();
        }
    }
}