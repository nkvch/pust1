function [y] = simulateProces(pastY, U)
y = 0.9*pastY + 0.1*U;
end