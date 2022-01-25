options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 100, 'TimeLimit', 300);
[X] = ga(@pid_test,9,[],[],[],[],[],[],[],[],options);
X
