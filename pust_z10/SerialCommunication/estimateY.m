function [y] = estimateY(pastY, dU, s, t)
D=100;
y=0;

for j=1:1:t
    y = y + get_s(s,j)*dU(1000-j);
end

for j=1:1:D-1
    y = y + (get_s(s,j+t)-get_s(s,j))*dU(1000-j-t);
end

y=y+pastY;

end
function [y] = simulateProces(pastY, U)
y = 0.9*pastY + 0.1*U;
end
function [s] = get_s(stepResponse, k)
l= length(stepResponse);
if(k>l)
    s = 1;
else
    s = stepResponse(k);
end

end
