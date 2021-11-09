function [s] = get_s(stepResponse, k)
l= length(stepResponse);
if(k>l)
    s = stepResponse(l);
else
    s = stepResponse(k);
end

end
