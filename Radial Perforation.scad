translate([-50,0,0])
difference()
{
    sphere(47);
    
    sphere(43);
    
    radial_pattern(42, 10, 10)
    cylinder(r1=5, r2=5, h=6);
}

translate([50,0,0])
difference()
{
    sphere(47);
    
    radial_pattern(47,10,10)
    sphere(5);
}

function PI()=3.1415926535;

//Creates a "starburst' of cylinders outward from the origin. The cylinders are evenly spaced within fixed latitude bands, such that no two cylinders are closer than a certain longitudinal distance, and with a random offset. There will always be a cylinder at the north and south poles.
//min_radius: The distance from the origin of each cylinder's closest end.
//hole_length: the length of each cylinder
//hole_radius: the radius of each cylinder.
//long_distance: the minimum longitudinal distance between two cylinders.
//latitudes: the number of cylinders in each longitude meridian from pole to pole.
module radial_perforation(min_radius, hole_length, hole_radius, long_distance, latitudes)
{
    //From -90 to 90:
    latitude_increment=180/latitudes;
    for(lat_step=[1:latitudes-1])
    {
    //>The z-offset is min_radius * sin latitude.
        latitude=latitude_increment*lat_step;
        //Calculate the circumference of this latitude band.
        lat_radius=min_radius*sin(latitude);
        circumference=2*3.1415926535*lat_radius;
        longitudes=ceil(circumference/(hole_radius*2+long_distance));
        longitude_increment=360/longitudes;
        //Apply a random offset.
        long_offset=rands(0, longitude_increment, 1)[0];
        for(long_step=[0:longitudes-1])
        {
    //>>First apply a x rotation based on latitude, then a z rotation based on longitude.
            longitude=(long_step*longitude_increment+long_offset)%360;
            rotate([0, 0, longitude])
            rotate([latitude, 0, 0])
            translate([0, 0, min_radius])
            cylinder(r2=hole_radius, r1=hole_radius, h=hole_length);
        }
    }
    //Draw the poles.
    translate([0,0,min_radius])
    cylinder(r2=hole_radius, r1=hole_radius, h=hole_length);
    rotate([0, 180, 0])
    translate([0, 0, min_radius])
    cylinder(r2=hole_radius, r1=hole_radius, h=hole_length);
}

module radial_pattern(radius, long_distance, lat_distance)
{
    latitudes=PI()*radius/lat_distance;
    lat_increment=180/latitudes;
    for(lat_step=[1:latitudes])
    {
        latitude=lat_step*lat_increment;
        long_radius=radius*sin(latitude);
        circumference=PI()*2*long_radius;
        longitudes=floor(circumference/long_distance);
        longitude_increment=360/longitudes;
        long_offset=rands(0,longitude_increment,1)[0];
        for(long_step=[0:longitudes-1])
        {
            longitude=(long_step*longitude_increment+long_offset)%360;
            rotate([0, 0, longitude])
            rotate([latitude, 0, 0])
            translate([0, 0, radius])
            children();
        }
    }
        translate([0,0,radius])
    children();
    rotate([0, 180, 0])
    translate([0, 0, radius])
    children();
}