function clfAll()
figlist = get(0,'Children');
for i = 1:length(figlist)
	clf(figlist(i));
end

end
