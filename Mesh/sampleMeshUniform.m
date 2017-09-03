% sample points uniformly on a mesh model
% Inputs
% 	mesh: matlab style mesh struct. vertices: Kx3, faces: Lx3
% 	N: number of samples
% 	area: optional, vector of faces area
function samples = sampleMeshUniform(mesh, N, area)

if nargin < 3
	A    = mesh.vertices(mesh.faces(:, 1), :)';
	B    = mesh.vertices(mesh.faces(:, 2), :)';
	C    = mesh.vertices(mesh.faces(:, 3), :)';
	a    = normByCol(A-B);
	b    = normByCol(B-C);
	c    = normByCol(C-A);
	p    = (a+b+c)/2;
	area = sqrt(p.*(p-a).*(p-b).*(p-c));
end

% sample triangles
area_bin   = area/sum(area);
Nsamples   = mnrnd(N, area_bin);
id_sampled = find(Nsamples > 0);

samples      = zeros(3, N);
sample_count = 0;
for t = 1:length(id_sampled)
	idt = id_sampled(t);
	Nt  = Nsamples(idt);

	p1                  = zeros(3); % the sampled triangle
	p1(:,1)             = mesh.vertices(mesh.faces(idt, 1), :)';
	p1(:,2)             = mesh.vertices(mesh.faces(idt, 2), :)';
	p1(:,3)             = mesh.vertices(mesh.faces(idt, 3), :)';
	samples(:, sample_count+1:sample_count+Nt) = sampleTriUniform(p1(:,1), p1(:,2),p1(:,3), Nt);

	sample_count = sample_count + Nt;
end
assert(sample_count == N);
