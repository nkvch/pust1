options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 300);
[X] = ga(@aproksymacja_fun,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)