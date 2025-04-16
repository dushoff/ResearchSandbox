
We are interested in finding the pseudo-inverse of a “big” reduced-rank correlation matrix $A = U^T U$, where $U$ is a “wide” $r \times n$ generator matrix. The goal is to not do any hard computations with “big matrices”. The complementary “small” matrix is $B = U U^T$.

This covers only the “generic” case where B is invertible.

Apparently, as suggested by AI, the (“long”) pseudo-inverse of $U$ is given by $U' = U^T B^{-1}$. We can confirm this:

$$
	U U' = U U^T B^{-1} = B B^{-1} = I.
$$

The pseudo-inverse of $A$ is then given by $$A' = U' U'^T = U^T B^{-2} U$$

We confirm this in three steps:

Construct a mapping matrix 
$$
	M  = A'A 
	$$$$ =  U^T B^{-2} U \ U^T U 
	=  U^T B^{-2} (U U^T) U 
	$$$$ =  U^T B^{-1} U 
$$

Confirm
$$
	MA'
	$$$$ = U^T B^{-1} U \ U^T B^{-2} U
	$$$$ = U^T (B^{-1} U U^T) B^{-2} U
	$$$$ = U^T  B^{-2} U
	$$$$ = A'
$$

Confirm
$$
	AM
	$$$$ = U^T U \ U^T B^{-1} U 
	$$$$ = U^T (U \ U^T B^{-1}) U 
	$$$$ = U^T  U 
	$$$$ = A
$$
