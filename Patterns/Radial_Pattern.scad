use <Pattern.scad>

p=sphere_volume(20,[4,4,5],0);

pattern(p)
{
    rotate([0,90,0])
    cylinder(10,1,0,true);
};

///Fills a specified spherical volume. Note that the north pole of each layer is the +y direction and the prime meridian is by default in the +x direction.
///radius: The radius of the sphere.
///spacing: The distance between each object and the next. Format is [east-west, north-south, up-down].
///random_offset: Scale factor to apply to random offsets on each ring. 0 for all prime meridians to be aligned.
function sphere_volume(radius,spacing,random_offset=0)=
[
    for(r=[0:spacing[2]:radius]) 
        each sphere_skin(r,spacing, random_offset)
];

///Each point on the surface of a specified spherical volume.
///radius: The radius of the sphere.
///spacing: The distance between each object and the next. Format is [east-west, north-south, up-down (irrelevant)]
///random_offset: Scale factor to apply to random offsets on each ring. 0 for a visible prime meridian.
function sphere_skin(radius, spacing, random_offset=0)=
[
    for(azimuth=[-90:90*spacing[1]/(PI*radius):90]) 
        each sphere_ring(azimuth, radius, spacing,random_offset*rands(0,360,1)[0])
];
    
/// Each point on a specified latitude of a specified spherical volume.
///latitude: the latitude of the ring.
///radius: the radius of the sphere.
///spacing: The distance between each object and the next. Format is [east-west, north-south (irrelevant), up-down (irrelevant)]
///offset: The degrees by which this latitude is offset from the prime meridian.
function sphere_ring(latitude, radius, spacing, offset=0)=
[    
    for(longitude=[offset:180*spacing[0]/(PI*radius*cos(latitude)):360+offset])
        [[1,1,1],
    [0,-longitude,latitude],
    [
    cos(longitude)*cos(latitude)*radius,//x
    sin(latitude)*radius,//y
    cos(latitude)*sin(longitude)*radius]]
];