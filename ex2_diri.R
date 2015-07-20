# useful for sampling from the Dirichlet distribution
library(MCMCpack)

# maximum number of Dirichlet random vars to sample
maxiters = 1000

ex2_draw_diris <- function(K,a_scalar) {
# function ex2_draw_diris_diffa but with both parameters equal

	ex2_draw_diris_diffa(rep(a_scalar,K))
}

ex2_draw_diris_diffa <- function(a_vector) {
# Samples and illustrates Dirichlet random variables.
#
# Args:
#  a_vector: the Dirichlet parameters
#
# Returns:
#  Nothing.
#
# For each press of "enter" samples a Dirichlet random var
# and illustrates it as a distribution over {1,2,...,K},
# where K is the length of the parameter vector.
# Press 'x' when finished making samples.

	K = length(a_vector)
	for(iter in 1:maxiters) {
		# Dirichlet random variable sample
		rho = rdirichlet(1,a_vector)

		# put Dirichlet parameters in the plot title
		a_vector_str = toString(a_vector)
		plot(as.vector(rho),
			type="h",
			xlim=c(0,K+1),
			ylim=c(0,1),
			ylab="frequencies",
			xlab="index",
			xaxt='n',
			col="red",
			lwd=5,
			main=bquote(rho~"~Dirichlet("~.(a_vector_str)
                                ~")")
			)
		axis(1,
			at=seq(0,K+1,by=1),
			labels=c("",paste(1:K),"")
			)

		# Generate a new draw for each press of "enter"
                # Press 'x' when finished
		line <- readline()
		if(line == "x") return('done');
	}
}
