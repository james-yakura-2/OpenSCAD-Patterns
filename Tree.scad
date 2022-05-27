min_length=5;
max_length=15;
radius=1;
scale_down_min=3/6;
scale_down_max=max(4/7,scale_down_min);
angle_min=30;
angle_max=90;
max_protrusions=5;
min_protrusions=0;

branch(3);

module branch(depth,scale_down=rands(scale_down_min,scale_down_max,1)[0], offset=rands(0,360,1)[0],length=rands(min_length, max_length,2)[0],ends=rands(min_protrusions,max_protrusions,1)[0])
{
    cylinder(length,radius,radius*scale_down);
    translate([0,0,length])
    sphere(radius*scale_down);
    if(depth>0)
    {
        translate([0,0,length])
        scale([scale_down,scale_down,scale_down])
        {
        for(i=[0:ends])
            rotate([0,0,i*360/(ends+1)+offset])
            rotate([0,rands(angle_min,angle_max,1)[0],0])
        branch(depth-1);
        branch(depth-1);
        }
    }
}