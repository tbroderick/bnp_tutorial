# Illustration of beta random variables.
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
