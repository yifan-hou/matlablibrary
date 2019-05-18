function SE3 = pose2SE3(pose)
    SE3 = eye(4);
    SE3(1:3, 4) = pose(1:3);
    SE3(1:3, 1:3) = quat2SO3(pose(4:7));
end