using SparseArrays
using .RCMreorder
AMatrix = spzeros(8,8);
AMatrix[1,1] = 1;   AMatrix[1,5] = 1;
AMatrix[2,2] = 1;   AMatrix[2,3] = 1;   AMatrix[2,6] = 1;   AMatrix[2,8] = 1;
AMatrix[3,2] = 1;   AMatrix[3,3] = 1;   AMatrix[3,5] = 1;
AMatrix[4,4] = 1;   AMatrix[4,7] = 1;
AMatrix[5,1] = 1;   AMatrix[5,3] = 1;   AMatrix[5,5] = 1;
AMatrix[6,2] = 1;   AMatrix[6,6] = 1;   AMatrix[6,8] = 1;
AMatrix[7,4] = 1;   AMatrix[7,7] = 1;
AMatrix[8,2] = 1;   AMatrix[8,6] = 1;   AMatrix[8,8] = 1;

adjacency = AdjObtain(AMatrix);
new_order = RCM(adjacency)