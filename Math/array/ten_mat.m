% calculates C = A * B. A is a 3D tensor, B is a 2D matrix.
% id = 1, 2, 3 is the dimension of A to be multiplied with B.
% Default: id = 2
% 	C(:,:,1) = A(:,:,1)*B
% 	C(:,:,2) = A(:,:,2)*B
% 	...
% 
function [C] = ten_mat(A, B, id)
[m,n,r] = size(A);
if nargin == 2
	id = 2;
end
switch id
	case 1
		C = permute(reshape(reshape(permute(A,[2 3 1]),[],m)*B,n,r,[]),[3 1 2]);
	case 2
		C = permute(reshape(reshape(permute(A,[1 3 2]),[],n)*B,m,r,[]),[1 3 2]);
	case 3
		C = reshape(reshape(A,[],r)*B,m,n,[]);
	otherwise
		error('id has to be 1, 2 or 3');
end



end