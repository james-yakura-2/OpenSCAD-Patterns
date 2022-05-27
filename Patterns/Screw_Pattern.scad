use <Pattern.scad>
threads=6;
radius=20;

p=screw_thread(10,20,2/threads,20);
pattern(rotations(threads))
hull_pattern(p)
{
    cylinder(5,radius*.5/threads,0,true);
}


function screw_thread(radius, height, slope, resolution)=
[
    for(y=[-height/2:height/resolution:height/2])
        [[1,1,1],[0,360*y/(slope*2*PI*radius),0],[sin(360*y/(slope*2*PI*radius))*radius,y,cos(360*y/(slope*2*PI*radius))*radius]]
];
    
function rotations(threads)=
    [
    for(thread=[1:threads])
        [[1,1,1],[0,thread*360/threads,0],[0,0,0]]
    ];
    