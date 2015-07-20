# maximum number of data points to draw
maxN = 1000

# use these parameters by default
K_default = 1000
a_default = 10/K_default
# note: default run with these parameters
# appears at the end

ex3_gen_largeK_diri <- function(K,a) {
# Illustrates cluster assignments using
# Dirichlet-distributed component probabilities
#
# Args:
#  K: Dirichlet parameter vector length
#  a: Dirichlet parameter (will be repeated K times)
#
# Returns:
#  Nothing
#
# Illustrates Dirichlet-distributed samples
# as a partition of the unit interval
# (cf. Kingman paintbox) and illustrates
# samples from this (random) distribution

	# make the Dirichlet draw
	rhomx = rdirichlet(1,rep(a,K))
	# various other useful forms of rho
	rho = as.vector(rhomx)
	rhomxt = t(rhomx)
	crho = c(0,cumsum(rho))

	# initialize bar colors so that
	# no components have been chosen yet
	# "grey" = not chosen, "blue" = chosen
	bar_colors = rep("grey",K)

	# special plot size for very horizontal fig
	x11(width=8,height=3)

	for(N in 0:maxN) {
		# want the option to illustrate
		# before draws are made
		if(N > 0) {
			# uniform draw to decide which component is chosen
			u = runif(1)
			draw = max(which(crho < u))
	
			# update bar color of chosen component
			bar_colors[draw] = "blue"
		}

		# bar plot makes it easy to plot
		# probabilities one after another
	        barplot(rhomxt,
	                beside=FALSE,
	                horiz=TRUE,
	                col=bar_colors,
			width=0.7,
			ylim=c(0,1),
			main=bquote(rho~"~Dirichlet"  # ~"("~.(a)~",...,"~.(a)~")"
                                ~", K="~.(K)~", N="~.(N))
       	        )

		if(N > 0) {
			# illustrate the uniform random variable
			points(u, 0.9, pch=25, col="red", bg="red")
		}
	
		# Generate a new draw for each press of "enter"
                # Press 'x' when finished
	        line <- readline()
	        if(line == "x") {
			dev.off()
			return("done")
		}
	}
}	

# default run with default parameters
ex3_gen_largeK_diri(K_default, a_default)


