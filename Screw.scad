difference()
{
    screw(30, 50, 10, 2, 3, 100);
    
    translate([0,0,-1])
    cylinder(r1=40, r2=40, h=32);
}

translate([0,0,40])
difference()
{
    cylinder(r1=60, r2=60, h=30);
    
    translate([0,0,-1])
    screw(32,50,10,2,3,100);
}

//Creates a screw.
//screw_length: The length of the screw.
//screw_radius: The radius of the part of the screw beneath the threads.
//thread_radius: The radius of the threaded portion of the screw.
//thread_width: The width of the threads.
//thread_num: The number of distinct threads.
//resolution: The number of thread samples per sweep-out of a circle with all threads.
module screw(screw_length, screw_radius, thread_radius, thread_width, thread_num, resolution)
{
    intersection()
    {
        union()
        {
            //Create the center of the screw.
            cylinder(r1=screw_radius, r2=screw_radius, h=screw_length);
            //Create the threads.
            threads(screw_length, screw_radius, thread_radius, thread_width, thread_num, resolution);
        }
        //Cut off the ends of the screw.
        cylinder(r1=screw_radius+thread_radius+1, r2=screw_radius+thread_radius, h=screw_length);
    }
}

module threads(screw_length, screw_radius, thread_radius, thread_width, thread_num, resolution)
{
    //>Calculate:
    //>The angle between threads at each samples.
    thread_separation=360/thread_num;
    //>The angle covered between samples.
    sample_angle_difference=thread_separation/resolution;
    //>The vertical distance between samples.
    sample_distance=thread_width*2/resolution;
    //>The total number of samples.
    samples=screw_length/sample_distance;
    for(sample=[0:samples])
    {
        for(thread=[0:thread_num-1])
        {
            translate([0,0,sample*sample_distance])
            rotate([0,0,thread*thread_separation+sample*sample_angle_difference])
            rotate([90,0,0])
            translate([0,0,screw_radius-1])
            cylinder(r1=thread_width, r2=0, h=thread_radius+1);
        }
    }
}