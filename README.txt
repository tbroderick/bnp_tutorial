To recreate the examples from the tutorial,
open R and run the following commands at the R prompt.

==============================================
====   Tutorial Day 1
==============================================

Load the functions for Example 1:
> source("ex1_beta.R")

Draw a random distribution using a beta random variable
with parameters (1,1).
Keep pressing enter to get more iid beta random variables.
Press "x" and then enter when you're done.
> ex1_draw_betas(1)
Choose a very small parameter tuple
> ex1_draw_betas(0.01)
Choose a very large parameter tuple
> ex1_draw_betas(1000)
Choose different parameters
> ex1_draw_betas_diffa(7,2)
Choose larger but still different parameters
> ex1_draw_betas_diffa(7000,2000)

==============================================
====   Tutorial Day 2
==============================================

Load the functions for Example 2.
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

Note: though we didn't cover it in the tutorial,
you can use the function "ex2_draw_diris_diffa"
to draw random distributions using different Dirichlet parameters.
e.g. > ex2_draw_diris_diffa(c(1,3,5,2))

Load Example 3.
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

Load Example 4.
Look at the cluster assignments according to a Dirichlet distribution with large K.
> source("ex4_largeK_count.R")
Press enter to keep making draws from the random distribution.
Press "x" and then enter when you're done.

We can also see how varying a changes the growth behavior.
To recreate the default, use:
> ex4_gen_largeK_count(K=1000,a=0.01)
But we could try a different a.
E.g., > ex4_gen_largeK_count(K=1000,a=1)

Note: though we didn't cover it in the tutorial,
you can use the function "ex4_gen_largeK_count"
to draw cluster assignments with different values of K.

==============================================
====   Tutorial Day 3
==============================================

Load the functions for Example 5:
> source("ex5_gem.R")

Draw a random distribution with GEM parameter alpha.
We tried alpha=1,10,100.
E.g. > ex5_draw_gem(alpha=10)

Load Example 6:
> source("ex6_dpmm.R")
Press enter to keep making draws from the DPMM.
Enter a number to make a larger number of draws at once.
Press "x" and then enter when you're done.

Load the functions for Example 7:
> source("ex7_monte_carlo_pi.R")

Draw uniform random variables to illustrate
approximating the mathematical constant pi using 
Monte Carlo:
> ex7_draw_monte_carlo()
Press enter to keep making uniform samples.
Enter a number to make that many samples.
Press "x" and then enter when you're done.

==============================================
====   Tutorial Day 4
==============================================

Load Example 8
Draw a random, simulated data set.
Run a Gibbs sampler for a 2-component Gaussian mixture model
with all data points initialized to clusters uniformly
at random.
> source("ex8_mm_sampler.R")
Press enter to keep making Gibbs samples.
Enter a number to go that many full iterations forward in the sampler.
Press "x" and then enter when you're done.

Load Example 9
Draw a random, simulated data set.
Run a Gibbs sampler for a CRP Gaussian mixture model
with all data points initialized to the same cluster.
> source("ex9_dpmm_sampler.R")
Press enter to keep making Gibbs samples.
Enter a number to go that many full iterations forward in the sampler.
Press "x" and then enter when you're done.

Run a Gibbs sampler for a CRP Gaussian mixture model
with all data points initialized to their own cluster.
> ex9_crp_gibbs(data=data$x, sd=1, initz=1:nrow(data$x))

Note: though we didn't cover it in the tutorial,
you can generate a new data set, possibly
with a different data set size or with
different cluster widths, with the function
"ex9_gen_data".
e.g. > data = ex9_gen_data(Ndata=1000,sd=0.3)

==============================================
====   Tutorial Day 5
==============================================

Load Example 10
> source("ex10_linear_regression.R")

Generate some fake data.
Note: this step will be used as input for future
steps, so make sure to run it first.
> data <- gen_data()

Illustrates the posterior on the intercept
and slope on the lefthand side. Illustrates the 
data seen so far as well as (optionally)
draws from the posterior on the righthand side.
> bayes_regr(data)

Same as the above in the left and center panels.
Has a new righthand panel that illustrates the
predictive distribution at a chosen x value ("xpred").
> bayes_regr(data,predict=TRUE,xpred=0.8)

