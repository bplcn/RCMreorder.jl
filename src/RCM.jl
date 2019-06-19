function AdjObtain(AMatrix::SparseMatrixCSC{Float64,Int64})
"""
This function can read the adjacency of sparse matrix A.
"""
    n = size(AMatrix,1);    l = size(AMatrix,2);
    adjacency = Array{Array,1}(undef,n);

    ColArray = AMatrix.colptr;
    RowArray = AMatrix.rowval;

    @inbounds @simd for krow = 1:n
        adjacency[krow] = RowArray[ColArray[krow]:(ColArray[krow+1]-1)];
    end
    # adjacency = [AMatrix[krow,1:n].nzind for krow = 1:n];

    return adjacency

end

function DgsObatin(adjacency::Dict{Int, Vector{Int}})
"""
This function can return the length of the valid nonzero element in each line.
P.S. this function actually is useless. (:<)Z
"""
    
    degrees = Array{Int64,1}(undef,length(adjacency));
    for krow in keys(adjacency)
        degrees[krow] = length(adjacency[krow]);
    end
    return degrees

end


function RCM(adjacency::Array; P::Int=0)
"""
    This code copy from the NodeNumber.jl writen by Marja Rapo. 
    A good example can be seen in the list link:
http://ciprian-zavoianu.blogspot.com/2009/01/project-bandwidth-reduction.html

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Step 0: Prepare an empty queue Q and an empty result array R.
Step 1: Select the node in G(n) with the lowest degree (ties are broken arbitrarily) that 
    hasn't previously been inserted in the result array. Let us name it P (for Parent).
Step 2: Add P in the first free position of R.
Step 3: Add to the queue all the nodes adjacent with P in the increasing order of their degree.
Step 4.1: Extract the first node from the queue and examine it. Let us name it C (for Child).
Step 4.2: If C hasn't previously been inserted in R, add it in the first free position and add to Q 
    all the neighbours of C that are not in R in the increasing order of their degree.
Step 5: If Q is not empty repeat from Step 4.1 .
Step 6: If there are unexplored nodes (the graph is not connected) repeat from Step 1 .
Step 7: Reverse the order of the elements in R. Element R[i] is swaped with element R[n+1-i].0
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

"""

    n = length(adjacency);
    degrees = length.(adjacency);

    # check if the initial search dof has been set
    if P<=0
        # step 1&2
        P = argmin(degrees);
    end

    # step 0
    R = Int[P];
    # Q = Array{Int64,1}();

    for i=1:n
        if i > length(R)    # Step 6
            QArray = setdiff(collect(1:n),R);
            Q = QArray[argmin(degrees[QArray])];

            push!(R, Q)
            t = sort(adjacency[Q], by=j->degrees[j])
            for b in t
                if !(b in R)
                    push!(R, b)
                end
            end
        else
            t = sort(adjacency[R[i]], by=j->degrees[j]);
            for T in t
                if !(T in R)
                    push!(R, T)
                end
            end
        end
    end
    new_order = reverse(R)
    return new_order
end