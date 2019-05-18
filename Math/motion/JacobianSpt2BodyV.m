% Return the 6x6 jacobian matrix mapping from spt time derivative
% to body velocity.
% Jac * spt time derivative = body velocity
function Jac = JacobianSpt2BodyV(R)
Jac = eye(6);
Jac(4, 4) = R(1,3)*R(1,3) + R(2,3)*R(2,3) + R(3,3)*R(3,3);
Jac(4, 6) = -R(1,1)*R(1,3) - R(2,1)*R(2,3) - R(3,1)*R(3,3);
Jac(5, 4) = -R(1,1)*R(1,2) - R(2,1)*R(2,2) - R(3,1)*R(3,2);
Jac(5, 5) = R(1,1)*R(1,1) + R(2,1)*R(2,1) + R(3,1)*R(3,1);
Jac(6, 5) = -R(1,2)*R(1,3) - R(2,2)*R(2,3) - R(3,2)*R(3,3);
Jac(6, 6) = R(1,2)*R(1,2) + R(2,2)*R(2,2) + R(3,2)*R(3,2);

end