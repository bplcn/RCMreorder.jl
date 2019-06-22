# RCMreorder.jl
The RCMreorder.jl return a new order of the dof id to decrease the bandwidth of the system.
## Example
```
julia>using SparseArrays,RCMreorder,UnicodePlots

julia>AMatrix = spzeros(8,8);
julia>AMatrix[1,1] = 1;   AMatrix[1,5] = 1;
julia>AMatrix[2,2] = 1;   AMatrix[2,3] = 1;   AMatrix[2,6] = 1;   AMatrix[2,8] = 1;
julia>AMatrix[3,2] = 1;   AMatrix[3,3] = 1;   AMatrix[3,5] = 1;
julia>AMatrix[4,4] = 1;   AMatrix[4,7] = 1;
julia>AMatrix[5,1] = 1;   AMatrix[5,3] = 1;   AMatrix[5,5] = 1;
julia>AMatrix[6,2] = 1;   AMatrix[6,6] = 1;   AMatrix[6,8] = 1;
julia>AMatrix[7,4] = 1;   AMatrix[7,7] = 1;
julia>AMatrix[8,2] = 1;   AMatrix[8,6] = 1;   AMatrix[8,8] = 1;
julia>adjacency = AdjObtain(AMatrix);
julia>neworder = RCM(adjacency);
julia>spy(AMatrix);
julia>spy(AMatrix[neworder,neworder]);

```