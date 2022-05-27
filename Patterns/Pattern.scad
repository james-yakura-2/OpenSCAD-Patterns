cube([2,2,2],true);

transform2([[1,2,0.25],[30,60,45],[5,5,5]])
cube([2,2,2],true);

pattern
(
[
[[1,1,1],[45,45,45],[3,3,3]],
[[2,2,2],[60,60,60],[8,8,8]]
]
)
cube([2,2,2],true);

hull_pattern
(
[
[[1,1,1],[0,0,0],[5,0,0]],
[[1,1,1],[0,0,0],[5,5,0]],
[[1,1,1],[0,0,0],[-5,5,0]],
[[1,1,1],[0,0,0],[-5,-5,0]],
[[1,1,1],[0,0,0],[5,-5,0]]
]
)
cylinder(r1=1,r2=1,h=5);

module transform(s, angle, displacement)
{
    translate(displacement)
    rotate([0,0,angle[2]])
    rotate([0,angle[1],0])
    rotate([angle[0],0,0])
    scale(s)
    children();
}

module transform2(t)
{
    transform(t[0],t[1],t[2])
    children();
}

module pattern(p)
{
    for(x=p)
    {
        transform2(x)
        children();
    }
}

module hull_pattern(p)
{
    for(x=[0:len(p)-2])
    {
        hull()
        {
            transform2(p[x])
            children();
            transform2(p[x+1])
            children();
        }
    }
}

function transformation(scaling,rotation,displacement)=[scaling,rotation,displacement];