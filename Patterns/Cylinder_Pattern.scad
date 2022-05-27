use <Pattern.scad>

pattern(cylinder_volume(20,40,[5,5,5],1))
{
    cylinder(4,2,0);
}

function cylinder_volume(radius, height, spacing, random_offset)=
[
for(elevation=[-height/2:spacing[0]:height/2])
   each disk(radius, elevation, spacing,random_offset) 
];

function disk(radius, elevation, spacing,random_offset)=
[
for(r=[0:spacing[2]:radius])
    each ring(r,elevation,spacing,random_offset*rands(0,360,1)[0])
];

function ring(radius,elevation,spacing,offset)=
[
for(theta=[offset:180*spacing[1]/(PI*radius):offset+360])
    [[1,1,1],[0,theta,0],[sin(theta)*radius,elevation,cos(theta)*radius]]
];