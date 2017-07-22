% calculates C = A * B, A is a 2D matrix, B is a 3D tensor
% id = 1, 2, 3 is the dimension of B to be multiplied with A.
% default: id = 1
% 	C(:,:,1) = A*B(:,:,1)
% 	C(:,:,2) = A*B(:,:,2)
% 	...

function [C] = mat_ten(A, B, id)
[p, q] = size(A);
[m,n,r] = size(B);
if nargin == 2
	id = 1;
end
switch id
	case 1
		C = reshape(A*reshape(B,m,[]),p,n,r);
	case 2
		C = permute(reshape(A*reshape(permute(B,[2 1 3]),n,[]),[],m,r), [2 1 3]);
	case 3
		C = permute(reshape(A*reshape(permute(B,[3 1 2]),r,[]),[],m,n), [2 3 1]);
	otherwise
		error('id has to be 1, 2 or 3');
end

end