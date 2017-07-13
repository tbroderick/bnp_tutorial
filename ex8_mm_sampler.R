# A Gibbs sampler for a 2-component Gaussian mixture model
# Copyright (C) 2017, Tamara Broderick
# www.tamarabroderick.com

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# useful for working with multivariate normal distributions
library(mvtnorm)

# Note: default function call at the end

ex8_gen_data <- function(Ndata, sd) {
# generate 2-component Gaussian mixture model data for inference later
#
# Args:
#  Ndata: number of data points to generate
#  sd: covariance matrix of data points around the
#      cluster-specific mean is [sd^2, 0; 0, sd^2];
#      i.e. this is the standard deviation in either direction
#
# Returns:
#  x: an Ndata x D matrix of data points (D=2 data dimensions)
#  z: an Ndata-long vector of cluster assignments
#  mu: a K x D matrix of cluster means,
#      where K=2 is the number of clusters

	# matrix of cluster centers: one in each of two quadrants
	mu = matrix(c(-2,2, 2,-2), ncol=2, byrow=TRUE)
	# vector of component frequencies
	rho = c(0.6,0.4)

	# assign each data point to a component
	z = sample(1:length(rho), Ndata, replace=TRUE, prob=rho)
	# draw each data point according to the cluster-specific
	# likelihood of its component
	x = cbind(rnorm(rep(NA,Ndata), mu[z,1], rep(sd,Ndata)),
		rnorm(rep(NA,Ndata), mu[z,2], rep(sd,Ndata)))
	
	# return the data.
	# also return the cluster centers and means in case
	# that is useful for comparison
	list("x" = x, "z" = z, "mu" = mu)
}

ex8_gibbs <- function(data, sd, initz, hyperparams) {
# Run a Gibbs sampler for a CRP Gaussian mixture model
# on the data
#
# Args:
#  data: an Ndata x D matrix of data points
#  sd: we assume the Gaussian likelihood around any
#      cluster mean has covariance matrix diag(sd^2,...,sd^2);
#      so this is the standard deviation in any direction
#  initz: vector of strictly positive integers; initial
#      assignments of data points to clusters; takes
#      values 1,...,K (Should have as many unique values
#      as desired number of clusters)
#  hyperparams: The hyperparameters to the prior distribution.
#      E.g., for K=2, this would be two hyperparameters
#      such as "c(1,1)"
#
# Returns:
#  Nothing
#
# Note:
#  Has been tested only on D=2

	# two colors for the two clusters
  # should look reasonably different on screen
  palette(c("#023FA5","#8DD593"))

	# setup the plot into two parts:
	# the data and the probabilities for Gibbs sampling
	par(mar = rep(2,4))
	layout(matrix(c(1,2), 2, 1, byrow=TRUE),
        	heights=c(4,1)
        )
	
	# don't exceed this many Gibbs iterations
	maxIters = 1000
	# the algorithm will pause and plot after this
	# iteration number; 0 ensures it will plot right off
	minPauseIter = 0

	# dimension of the data points
	data_dim = ncol(data)
	# cluster-specific covariance matrix
	Sig = diag(sd^2,data_dim)
	# prior covariance matrix
	Sig0 = diag(3^2,data_dim)
	# cluster-specific precision (Sig^{-1})
	Prec = solve(Sig)
	# prior precision (Sig^{-1})
	Prec0 = solve(Sig0)
	# prior mean on cluster parameters
	mu0 = matrix(c(0,0), ncol=2, byrow=TRUE)
	# number of data points
	Ndata = nrow(data)

	# initialize the sampler
	z = initz  # initial cluster assignments
	counts = as.vector(table(z))  # initial data counts at each cluster
	Nclust = length(counts)	  # initial number of clusters

	# run the Gibbs sampler
	for(iter in 1:maxIters) {
		# take a Gibbs step at each data point
		for(n in 1:Ndata) {
			# get rid of the nth data point in the counts
			c = z[n]
			counts[c] = counts[c] - 1
			z[n] = -1  # ensures z[n] doesn't get counted as a cluster

			# unnormalized log probabilities for the clusters
			log_weights = rep(NA,Nclust)
			# find the unnormalized log probabilities
			# for each existing cluster
			for(c in 1:Nclust) {
				c_Precision = Prec0 + counts[c] * Prec
				c_Sig = solve(c_Precision)
				# find all of the points in this cluster
				loc_z = which(z==c)
				# sum all the points in this cluster
				if(length(loc_z) > 1) {
					sum_data = colSums(data[z == c,])
				} else if(length(loc_z) == 1) {
					sum_data = data[z == c,]
				} else {
          sum_data = 0
				}
        # posterior predictive mean for this cluster
				c_mean = c_Sig %*% (Prec %*% sum_data + Prec0 %*% t(mu0))
        # unnormalized log probability for this cluster
				log_weights[c] = log(counts[c] + hyperparams[c]) + dmvnorm(data[n,], mean = c_mean, sigma = c_Sig + Sig, log = TRUE)
			}

			# transform unnormalized log probabilities
			# into probabilities
			max_weight = max(log_weights)
			log_weights = log_weights - max_weight
			loc_probs = exp(log_weights)
			loc_probs = loc_probs / sum(loc_probs)

			# sample which cluster this point should
			# belong to
			newz = sample(1:Nclust, 1, replace=TRUE, prob=loc_probs)
			# if necessary, instantiate a new cluster
			if(newz == Nclust + 1) {
				counts = c(counts,0)
				Nclust = Nclust + 1
			}
			z[n] = newz
			# update the cluster counts
			counts[newz] = counts[newz] + 1
	
		# if desired, plot the progress of the sampler
		if(iter >= minPauseIter) {		
		
		# in the top plot, plot the points,
		# colored by cluster assignment in this sampler step
		plot(data, col=z, pch=19)
		# highlight which point is currently being sampled
		points(data[n,1], data[n,2], col="black", pch=4, lwd=4, cex=4)
		points(data[n,1], data[n,2], col="black", pch=19, lwd=1, cex=2)
	
		# plot the cluster probabilities for the Gibbs sampler.
		# color the probabilities by cluster
		barplot(as.matrix(loc_probs,nrow=length(loc_probs)),
        	        beside=FALSE,
        	        horiz=TRUE,
        	        ylim=c(0,1),
        	        width=0.7,
			col = palette(),
			main = paste("Gibbs iter = ", toString(iter),
        	        	", n = ", toString(n),
               		 	", ",
               		 	sep="")
			)

		# in the bottom plot, plot the Gibbs probabilities and sample
		u = loc_probs[newz] * runif(1)
		uplot = cumsum(loc_probs)[newz] - u
		# plot the uniform random number used to draw a probability
		points(uplot, 1, pch=25, col="red", bg="red")

		# Generate a new draw for each press of "enter"
                # Press 'x' when finished.
		# Enter a number to progress that many full
		# Gibbs iterations into the future.
		line <- readline()
        	if(line == "x") {
        	        dev.off()
        	        return("done")
        	} else if(line == "") {
        	} else {
        	        minPauseIter = iter + as.numeric(line)
        	}
		}
		}
	}
}

# generate a data set with 100 data points
data <- ex8_gen_data(Ndata=100,sd=1)
# run mixture model Gibbs sampler
# initialized uniformly at random
ex8_gibbs(data=data$x, sd=1, initz=sample(1:2, 100, replace=TRUE, prob=c(0.5,0.5)), hyperparams=c(1,1))





