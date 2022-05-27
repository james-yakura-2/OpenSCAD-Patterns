connect_in_sequence()
{
    translate([-1,-1,-1])
    cube(1);
    
    translate([1,1,1])
    cube(1);
    
    translate([-1,-1,1])
    cube(1);
};

module connect_in_sequence()
{
    for(i=[0:1:$children-2])
    {
        hull()
        {
            children(i);
            children(i+1);
        }
    }
}