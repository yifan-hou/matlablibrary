function pose = SE32Pose(SE3)
    pose = [SE3(1:3,4); SO32quat(SE3(1:3,1:3))];
end