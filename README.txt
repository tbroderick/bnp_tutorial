To recreate the examples from the tutorial,
open R and run the following commands at the R prompt.

==============================================
====   Tutorial
==============================================

Load the functions for the first example.
(In longer versions of this tutorial, there is a first example
with beta random variables; hence the counting starts at 2.)
Note: you may need to install the MCMCpack package first: > install.packages("MCMCpack")
> source("ex2_diri.R")

Draw a random distribution using a Dirichlet random variable
with all parameters 1.
Keep pressing enter to get more iid Dirichlet random variables.
Press "x" and then enter when you're done.
> ex2_draw_diris(K=4,a_scalar=1)
Choose a very small shared parameter
> ex2_draw_diris(K=4,a_scalar=0.01)
Choose a very large shared parameter
> ex2_draw_diris(K=4,a_scalar=1000)
Try using Dirichlet parameters that are not all the same
> ex2_draw_diris_diffa(c(1,1,1,1000))

Load the second example.
Draw a Dirichlet distribution with large K.
> source("ex3_largeK_distr.R")
Press enter to keep making draws from the random distribution.
Press "x" and then enter when you're done.
To repeat the default settings:
> ex3_gen_largeK_diri(K=1000,a=0.01)
For larger a, try:
> ex3_gen_largeK_diri(K=1000,a=1)
For smaller a, try:
> ex3_gen_largeK_diri(K=1000,a=0.001)

Note: in the tutorial we tried out different values
of a. Although we didn't cover it in the tutorial,
you can use the function "ex3_gen_largeK_diri"
to also try out different values of K.

Load the third example.
Look at the cluster assignments according to a Dirichlet distribution with large K.
> source("ex4_largeK_count.R")
Press enter to keep making draws from the random distribution.
Press "x" and then enter when you're done.

Note: though we didn't cover it in the tutorial,
you can use the function "ex4_gen_largeK_count"
to draw cluster assignments with different values of K and a.
E.g. > ex4_gen_largeK_count(K=1000,a=0.01)

Load the functions for the fourth example.
> source("ex5_gem.R")

Draw a random distribution with GEM parameter alpha.
We tried alpha=10.
E.g. > ex5_draw_gem(alpha=10)
I suggested a "homework exercise" to think about what happens
when alpha=1 or 100. Hint: use knowledge of the beta distribution.

Load the fifth example.
> source("ex6_dpmm.R")
Press enter to keep making draws from the DPMM.
Enter a number to make a larger number of draws at once.
Press "x" and then enter when you're done.
