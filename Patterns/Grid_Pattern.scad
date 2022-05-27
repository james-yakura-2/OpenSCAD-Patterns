use <Pattern.scad>

pattern(volume([100,100,100],[30,30,30]))
cube([1,1,1],true);


function row(width,spacing,y,z)=
[for(x=[-(width-spacing-width%spacing)/2:spacing:(width-spacing-width%spacing)/2])     
[[1,1,1],[0,0,0],[x,y,z]]
];
    
function level(width, depth, x_spacing, y_spacing, z)=
[
for(y=[-(depth-y_spacing-depth%y_spacing)/2:y_spacing:(depth-y_spacing-depth%y_spacing)/2]) each row(width,x_spacing,y,z)
];

function volume(dimensions,spacings)=
[
for(z=[-(dimensions[2]-spacings[2]-dimensions[2]%spacings[2])/2:spacings[2]:(dimensions[2]-spacings[2]-dimensions[2]%spacings[2])/2])
    each level(dimensions[0],dimensions[1],spacings[0],spacings[1],z)
];