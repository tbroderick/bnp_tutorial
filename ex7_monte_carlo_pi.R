# Illustration of Monte Carlo to estimate the constant pi.
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

# maximum number of sampling iterations
maxiters=10000

color_fcn <- function(ind) {
# Translates an indicator variable into a color.
#
# Returns:
#   "green" if indicator is TRUE and "red" otherwise.
  cols = if (ind) "green" else "red"
}

ex7_draw_monte_carlo <- function() {
# Samples uniform random variables in the first quadrant unit square,
# i.e. in [0,1] x [0,1] to illustrate a Monte Carlo approximation
# to pi. Displays the running estimate of pi in a figure together
# with the points sampled so far.
# 
# Returns:
#  Nothing.
#
# For each press of "enter" samples a uniform random variable
# in [0,1]^2 and illustrates it as a point. The point is
# green if within the unit circle around (0,0) and red otherwise.
# A running approximation of pi based on the samples is written
# as the title of the plot.
# Press 'x' when finished making samples.
  
  pi_est = 0 # running estimate of pi
  x = c() # uniform variables sampled so far on horizontal axis
  y = c() # uniform variables sampled so far on vertical axis
  cols = c() # colors for uniform variables sampled so far
  totalN = 0 # total samples so far
  newN = 0 # number of new samples on this round of sampling

  # run the Monte Carlo sampler
	for(iter in 1:maxiters) {
    # plot all of the samples so far
	  plot(x,y,
	       xlim=c(0,1),
	       ylim=c(0,1),
	       xlab="",
	       ylab="",
         col=cols,
         pch=16)
    
    # update the total number of samples with the desired number of new samples
    totalN = totalN + newN
    # check if there are new samples requested on this round
    if(newN > 0){
      u1 = runif(newN) # horizontal iid uniform random variables
      u2 = runif(newN) # vertical iid uniform random variables
      # collect the new and old samples
      x = c(x,u1)
      y = c(y,u2)
      
      # check if the new samples are inside the unit circle around (0,0)
      ind = u1^2 + u2^2 < 1
      # update the estimate of pi based on the new samples
      pi_est = pi_est + (1/totalN) * (4.0 * sum(ind) - newN * pi_est)
		
      # color points by whether they are inside the unit circle at (0,0)
      pt_colors = sapply(ind,color_fcn)
      # collect the new and old color assignments
      cols = c(cols,pt_colors)
      # plot the new samples
		  points(u1, u2,
			  pch=16,
			  col=pt_colors
			  )
    }
    
    # the title reflects the running estimate of pi
    title(main=bquote(pi~" is about "~.(pi_est)))
		
		# Generate a new draw for each press of "enter"
		# Writing a number generates that many new samples.
		# Press 'x' when finished
		line <- readline()
		if(line == "x") {
      return("done")
  	} else if(line == "") {
	    newN = 1
	  } else {
	    newN = as.numeric(line)
	  }
	}
}
