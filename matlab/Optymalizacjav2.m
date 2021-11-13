options = gaoptimset('StallGenLimit', 1000, 'PopulationSize', 1000);
[X] = ga(@PID_funcv2,3,[],[],[],[],[],[],[],[],options);
fprintf('\nK=%f; Ti=%f; Td=%f;\n', X)