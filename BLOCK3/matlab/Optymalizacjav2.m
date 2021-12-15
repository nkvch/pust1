options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 100);
[X] = ga(@PID_funcv2,3,[],[],[],[],[],[],[],[],options);
fprintf('\nK=%f; Ti=%f; Td=%f;\n', X)