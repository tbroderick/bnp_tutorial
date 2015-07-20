# Illustration of beta random variables

# maximum number of beta random variables to sample
maxiters=1000

ex1_draw_betas <- function(a) {
# Function draw_betas_diffa but with both parameters equal

	ex1_draw_betas_diffa(a,a)
}

ex1_draw_betas_diffa <- function(a1,a2) {
# Samples and illustrates beta random variables.
#
# Args:
#  a1, a2: the beta parameters
# 
# Returns:
#  Nothing.
#
# For each press of "enter" samples a beta random variable
# and illustrates it as a distribution over {1,2}.
# Press 'x' when finished making samples.

	for(iter in 1:maxiters) {
		# beta random variable sample
		rho = rbeta(1,a1,a2)
		
		plot(c(rho,1-rho),
			type="h",
			xlim=c(0,3),
			ylim=c(0,1),
			ylab="frequencies",
			xlab="index",
			xaxt='n',
			col="red",
			lwd=5,
			main=bquote("("~rho[1]~","~rho[2]~")~Beta("~.(a1)
				~","~.(a2)~")")
			)
		axis(1,
			at=seq(0,3,by=1),
			labels=c("","1","2","")
			)
		
		# Generate a new draw for each press of "enter"
		# Press 'x' when finished
		line <- readline()
		if(line == "x") return("done")
	}
}
