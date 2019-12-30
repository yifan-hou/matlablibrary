clear;clc;
Re{1} = [-0.7071    0.7071;
    0.7071    0.7071;
   -0.7071   -0.7071];
Rh{1} = [-0.7071    0.7071   -0.7071    0.7071;
    0.7071    0.7071    0.7071    0.7071;
    1.4142    0.0000   -0.0000   -1.4142];
R{1} = coneIntersection(Re{1}, Rh{1});

Re{2} = [-0.7071    0.7071;
    0.7071    0.7071;
    0.7071    0.7071];
Rh{2} = [-0.7071    0.7071   -0.7071    0.7071;
    0.7071    0.7071    0.7071    0.7071;
    1.4142    0.0000   -0.0000   -1.4142];
R{2} = coneIntersection(Re{2}, Rh{2});

Re{3} = [-0.7071    0.7071   -0.7071    0.7071;
    0.7071    0.7071    0.7071    0.7071;
    0.7071    0.7071   -0.7071   -0.7071];
Rh{3} = [-0.7071    0.7071   -0.7071    0.7071;
    0.7071    0.7071    0.7071    0.7071;
    1.4142    0.0000   -0.0000   -1.4142];
R{3} = coneIntersection(Re{3}, Rh{3});

figure(1);clf(1);hold on;
for i = 1:3
    disp(i);
    Re{i}
    Rh{i}
    R{i}
    plot3(0,0,0,'*r', 'markersize', 35);
    drawCone3D(Re{i}, 'g', true);
    drawCone3D(Rh{i}, 'b', true);
    drawCone3D(R{i}, 'r', true);
    clf; hold on;
end

