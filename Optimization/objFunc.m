function y = objFunc( x )
%objFunc the objective function to be optimized.
%   x:column vector
%   args:column vector,1:dim,2:type,3:smoothness
args = [7, 1, 7];


dim = args(1);
sm  = args(3);

if size(args,2) == 4
    switch args(2)
        case 1 %sinc
            den = ones(1,dim) * abs(x-5);
            num = sin((10.3-sm)*den);
            if den == 0
                y = -10.3+sm;
            else
                y=-num./((10.3-sm)*den);
            end
        case 2 %multimodal
            t1=(x-5).*(x-5)-10*cos((10.3-sm)*pi*(x-5));
            y=-900+ones(1,dim)*t1;
    end
    
else
    switch args(2)
        case 1 %sinc
            den = ones(1,dim) * abs(x-5);
            num = sin((10.3-sm)*den);
            if den == 0
                y = 1;
            else
                y=num./((10.3-sm)*den);
            end
        case 2 %multimodal
            t1=(x-5).*(x-5)-10*cos((10.3-sm)*pi*(x-5));
            y=900-ones(1,dim)*t1;
    end
end


end

