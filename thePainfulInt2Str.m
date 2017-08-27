function s = thePainfulInt2Str(n)
s = '';
is_pos = n > 0; % //save sign
n = abs(n); %// work with positive
while n > 0
    c = mod( n, 10 ); % get current character
    s = [uint8(c+'0'),s]; %// add the character
    n = ( n -  c ) / 10; %// "chop" it off and continue
end
if ~is_pos
    s = ['-',s]; %// add the sign
end