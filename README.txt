To recreate the examples from the tutorial,
open R and run the following commands at the R prompt.

==============================================
====   Tutorial Part I
==============================================

Load the functions for Example 1:
> source("ex1_beta.R")

Draw a random distribution using a beta random variable
with parameters (1,1).
Keep pressing enter to get more iid beta random variables.
Press "x" and then enter when you're done.
> ex1_draw_betas(1)
Choose a very small parameter tuple
> ex1_draw_betas(0.001)
Choose a very large parameter tuple
> ex1_draw_betas(1000)

Note: though we didn't cover it in the tutorial,
you can use the function "ex1_draw_betas_diffa"
to draw random distributions using both beta parameters.
e.g. > ex1_draw_betas_diffa(0.1,10)

Load the functions for Example 2.
Note: you may need to install the MCMCpack package first: > install.packages("MCMCpack")
> source("ex2_diri.R")

Draw a random distribution using a Dirichlet random variable
with all parameters 1.
Keep pressing enter to get more iid Dirichlet random variables.
Press "x" and then enter when you're done.
> ex2_draw_diris(K=4,a_scalar=1)
Choose a very small shared parameter
> ex2_draw_diris(K=4,a_scalar=0.001)
Choose a very large shared parameter
> ex2_draw_diris(K=4,a_scalar=1000)

Note: though we didn't cover it in the tutorial,
you can use the function "ex2_draw_diris_diffa"
to draw random distributions using different Dirichlet parameters.
e.g. > ex2_draw_diris_diffa(c(1,3,5,2))

Load Example 3
> source("ex3_largeK_distr.R")
Press enter to keep making draws from the random distribution.
Press "x" and then enter when you're done.

Load Example 4
> source("ex4_largeK_count.R")
Press enter to keep making draws from the random distribution.
Press "x" and then enter when you're done.

Load Example 5
> source("ex5_dpmm.R")
Press enter to keep making draws from the DPMM.
Press "x" and then enter when you're done.

==============================================
====   Tutorial Part III
==============================================

Load Example 6
Draw a random, simulated data set.
Run a Gibbs sampler for a CRP Gaussian mixture model
with all data points initialized to the same cluster.
> source("ex6_sampler.R")
Press enter to keep making Gibbs samples.
Enter a number to go that many full iterations forward in the sampler.
Press "x" and then enter when you're done.

Run a Gibbs sampler for a CRP Gaussian mixture model
with all data points initialized to their own cluster.
> ex6_crp_gibbs(data=data$x, sd=1, initz=1:nrow(data$x))

Note: though we didn't cover it in the tutorial,
you can generate a new data set, possibly
with a different data set size or with
different cluster widths, with the function
"ex6_gen_data".
e.g. > ex6_gen_data(1000,0.3)

