# Illustration of Bayesian linear regression with unknown mean
# Copyright (C) 2015, Tamara Broderick
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

# for multivariate normal calculations
library(mvtnorm)
# since R filled.contour has some issues with multiple plots in same figure
source("filled.contour3.R")

# the Gaussian standard deviation in the likelihood
sigma = 0.2
# some pre-processing calculations
sigma_sq = sigma*sigma
sigma_sq_inv = 1/sigma_sq

gen_data <- function(n=10000, theta0=-0.3, theta1=0.5) {
# Samples n fake data pairs (x^i, y^i) independently
# where each x^i is iid uniformly distributed on [-1,1]
# and conditional on x^i, y^i is normally distributed
# with mean theta0 + x*theta1 and variance sigma = 0.2
#
# Args:
#  theta0: the intercept of the line
#  theta1: the slope of the line
#
# Returns:
#  An n x 2 array of data pairs.
	
	# X ~ Unif[-1,1]
	x = runif(n)*2 - 1
	
	# Y | X = x ~ N(theta0 + x*theta1, sigma^2)
	y = rnorm(n)*sigma + theta0 + x*theta1
	
	cbind(x,y)
}

bayes_regr <- function(data, predict=FALSE, xpred=-0.8, sigma0_sq = 1, mu0=c(0,0)) {
# Illustrates Bayesian linear regression with unknown mean.
#
# Args:
#  data: an n x 2 array of data pairs
#  predict: a boolean of whether to plot the posterior predictive
#  xpred: if plotting posterior predictive, which x value to predict at
#  sigma0_sq: prior variance in each direction
#  mu0: prior mean
#
# Returns:
#  Nothing.
	
	# if plotting posterior predictive distribution, need 3 plots in same figure
	if(predict) par(mfrow=c(1,3))
	else par(mfrow=c(1,2)) # otherwise, only need 2 plots

	# discretization of x and y axes for plotting purposes
	x <- y <- seq(-1,1,len=100)

	# Initialize posterior mean and covariance matrix
	# to the prior values.
	# We will update these iteratively.
	mu = mu0
	Sigma <- sigma0_sq * matrix(c(1,0,0,1),nrow=2)
	
	# in order to calculate the posterior, 
	# it will be useful to have a running calculation
	# of the posterior precision and precision * mean
	Precision = solve(Sigma)
	Precision_mu <- Precision%*%mu
	
	# initialize: start plot with no data
	line = "s"
	# number of data points seen so far
	n = 0
	# keep plotting until someone inputs an 'x'
	while(line != "x") {
		# update the posterior if there is new data
		if(line != "s") {
			m = 0
			while(m < as.numeric(line)) {
				m = m + 1
				n = n + 1
				
				# phi vector for this new data point
				phi = matrix(c(1,data[n,1]),nrow=2)
				# update posterior precision
				Precision = Precision + sigma_sq_inv * phi%*%t(phi)
				# update posterior precision times mean
				Precision_mu = Precision_mu + sigma_sq_inv * phi * data[n,2]
				
				# calculate posterior covariance and mean
				Sigma = solve(Precision)
				mu = Sigma %*% Precision_mu
			}
		}
		
		# get the multivariate normal density on a grid for contour plotting
		z <- outer(x,y,
			FUN=function(x,y,...){
					apply(cbind(x,y),1,dmvnorm,...)
			}, mean=mu, sigma=Sigma)
		
		# contour plot the multivariate normal posterior
		# Uses filled.contour3 function from http://wiki.cbr.washington.edu/qerm/index.php/R/Contour_Plots
		filled.contour3(x,y,z, main=bquote("Posterior after"~.(n)
				~"data points"),
				xlab="theta_1 (intercept)", ylab="theta_2 (slope)",
				color.palette=topo.colors)
		
		# initialize the plot of data
		plot(2,type="n",xlim=c(-1,1),ylim=c(-1,1),xlab="x",ylab="y",
			main="Data")
		# if there's data, plot it
		if(n > 0) {
			points(matrix(data[1:n,],nrow=n))
		}
		
		# for each press of 'l', draw a line from the current posterior
		print("Press \'l\' and enter to plot a draw of a line from the current posterior. Press only enter to skip.")
		line <- readline()
		if(line == "l") {
			while(line == "l") {
				# draw the intercept and slope values
				theta = rmvnorm(1, mean=mu, sigma=Sigma)
				# plot the corresponding line
				abline(a=theta[1],b=theta[2], lwd=2, col="red")
				
				# plot more draws if desired
				print("Press \'l\' and enter to plot a draw of a line from the current posterior. Press only enter to skip.")
				line <- readline()
			}
			if(line == "x") return("done")
		} else if(line == "x") return("done")
		
		# if desired, plot a posterior predictive distribution at a particular x value
		if(predict) {
			# highlight the chosen x value on the data plot
			abline(v = xpred, lwd=3, lty=2, col="green")
			
			# pause before plotting the posterior predictive
			print("Press enter to continue.")
			line <- readline()
			if(line == "x") return("done")
		
			# get the phi vector for this x value
			phipred = matrix(c(1,xpred),nrow=2)
			
			# mean and variance of the posterior predictive distribution
			mupred = t(mu)%*%phipred
			vpred = sigma_sq + t(phipred)%*%Sigma%*%phipred
			
			# calculate the density values of the posterior predictive
			xdens = dnorm(y,mean=mupred,sd=sqrt(vpred))
			
			# plot the posterior predictive
			plot(0,type="n",xlim=c(0,max(xdens)),ylim=c(-1,1),
				main=bquote("Posterior predictive at x ="~.(xpred)))
			lines(xdens,y,lwd=3,col="green")
		}
		
		print("How many new data points should we add to the plot? Press enter when finished.")
		line <- readline()
	}
}