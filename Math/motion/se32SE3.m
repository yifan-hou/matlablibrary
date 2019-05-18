function SE3 = se32SE3(twist)
    SE3 = eye(4);
    v = twist(1:3);
    w = twist(4:6);
    theta = norm(w);
    if ( theta < 1e-6 )
        % no rotation
        SE3(1:3, 4) = v;
    else
        R = so32SO3(w)
        v = v/theta;
        w = w/theta;
        SE3(1:3, 1:3) = R;
        SE3(1:3, 4) = (eye(3) - R)*(cross(w, v)) + w*(w')*v*theta;
    end
end