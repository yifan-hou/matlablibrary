clear;clc;
% 2d cone
R{1} = [1 1 1;
    -1 1 1;
    0 1 1]';
Rs{1} = removeRedundantRays3D(R{1});

% 2d half plane
R{2} = [1 0 0;
    -1 0 0;
    0 1 0;
    1 1 0;
    -1 1 0]';
Rs{2} = removeRedundantRays3D(R{2});

% 2d plane: zero center
R{3} = [1 0 0;
    -1 0 0;
    0 1 0;
    0 -1 0]';
Rs{3} = removeRedundantRays3D(R{3});

% 2d plane: 1 antipodal pair
R{4} = [1 0 0;
    1 1 0;
    1 0.5 0;
    1 -1 0;
    -1 0 0]';
Rs{4} = removeRedundantRays3D(R{4});

% 2d plane: 2 antipodal pairs
R{5} = [1 0 0;
    -1 0 0;
    0 1 0;
    0 -1 0;
    1 1 0;
    -1 0.5 0
    -1 0 0]';
Rs{5} = removeRedundantRays3D(R{5});

% 3d cone
R{6} = [1 0 0;
    1 1 0;
    1 1 1;
    1 0 1;
    1 0.5 0.2;
    0.5 1 0.5]';
Rs{6} = removeRedundantRays3D(R{6});

% 3d edge
R{7} = [1 0 0;
    -1 0 0;
    1 1 0;
    1 1 1;
    -1 0.5 0.2;
    0 1 1]';
Rs{7} = removeRedundantRays3D(R{7});

% 3d half plane: 0 antipodals
R{8} = [1 0 0;
    1 0.5 0;
    1 1 0;
    -1 -0.6 0;
    -1 0.5 0.2;
    0 1 1]';
Rs{8} = removeRedundantRays3D(R{8});

% 3d half plane: 1 antipodals
R{9} = [1 0 0;
    1 0.5 0;
    1 1 0;
    -1 -0.5 0;
    -1 0.5 0.2;
    0 1 1]';
Rs{9} = removeRedundantRays3D(R{9});

% 3d half plane: 2 antipodals
R{10} = [1 0 0;
    1 0.5 0;
    1 1 0;
    -1 -0.5 0;
    -1 0 0;
    0 1 1;
    0.3 -0.6 1.2]';
Rs{10} = removeRedundantRays3D(R{10});

% 3d space
R{11} = [1 0 0;
    1 0.5 0;
    1 1 0;
    -1 -0.5 0;
    -1 0 0;
    0 1 1;
    0.3 -0.6 1.2;
    0 0.2 -1]';
Rs{11} = removeRedundantRays3D(R{11});

figure(1);clf(1);hold on;
for i = 1:11
    disp(i);
    R{i}
    Rs{i}
    plot3(0,0,0,'*r', 'markersize', 35);
    drawCone3D(R{i}, 'g', true);
    drawCone3D(Rs{i}, 'b', true);
    clf; hold on;
end

