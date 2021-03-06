\name{plotArrow}
\encoding{UTF-8}
\alias{plotArrow}

\title{Arrow sample plot}

\description{Represents samples from multiple coordinates.
}

\usage{
plotArrow(  object,
comp = NULL,
abline = FALSE,
xlim = NULL,
ylim = NULL,
group=NULL,
col,
cex,
pch,
title=NULL,
plot.arrows=TRUE,
legend=FALSE,
X.label = NULL,
Y.label = NULL,
ind.names=FALSE,
position.names='centroid'
)

}

\arguments{
\item{object}{object of class inheriting from \pkg{mixOmics}:  \code{PLS, sPLS, rCC, rGCCA, sGCCA, sGCCDA}}
\item{comp}{integer vector of length two indicating the components represented on the horizontal
and the vertical axis to project the individuals.}
\item{abline}{should the vertical and horizontal line through the center be plotted? Default set to \code{FALSE}}
\item{xlim}{the ranges to be encompassed by the \eqn{x} axis, if \code{NULL} they are computed.}
\item{ylim}{the ranges to be encompassed by the \eqn{y} axis, if \code{NULL} they are computed.}
\item{group}{factor indicating the group membership for each sample. Coded as default for the supervised method \code{sGCCDA, sPLSDA}, but needs to be input for the unsupervised methods \code{PLS, sPLS, rCC, rGCCA, sGCCA}}
\item{col}{character (or symbol) color to be used, color vector also possible.}
\item{cex}{numeric character (or symbol) expansion, , color vector also possible.}
\item{pch}{plot character. A character string or a vector of single characters
or integers. See \code{\link{points}} for all alternatives.}
\item{title}{set of characters for the title plot.}
\item{plot.arrows}{boolean. Whether arrows should be added or not. Default is \code{TRUE}.}
\item{legend}{boolean. Whether the legend should be added. Only for the supervised methods and if group!=NULL. Default is \code{FALSE}.}
\item{X.label}{x axis titles.}
\item{Y.label}{y axis titles.}
\item{ind.names}{If \code{TRUE}, the row names of the first (or second) data matrix are used as sample names (see Details). Can be a vector of length the sample size to display sample names.}
\item{position.names}{One of \code{"centroid", "start", "end"}. Define where sample names are plotted when \code{ind.names=TRUE}. In a multiblock analysis, centroid and start will display similarly. }
}

\details{
Graphical of the samples (individuals) is displayed in a superimposed manner where each sample will be
indicated using an arrow. The start of the arrow indicates the location of the sample in \eqn{X} in one plot,
and the tip the location of the sample in \eqn{Y} in the other plot.

For objects of class \code{"GCCA"} and if there are more than 3 blocks, the start of the  arrow indicates the centroid between all data sets for a given individual and the tips of the arrows the location of that individual in each block.

Short arrows indicate a strong agreement between the matching data sets, long arrows a disagreement between the matching data sets.
}

\author{Francois Bartolo, Kim-Anh Lê Cao.}

\seealso{\code{\link{arrows}}, \code{\link{text}}, \code{\link{points}} and http://mixOmics.org/graphics for more details.}

\references{
Lê Cao, K.-A., Martin, P.G.P., Robert-Granie, C. and Besse, P. (2009). Sparse canonical methods
for biological data integration: application to a cross-platform study. \emph{BMC Bioinformatics} \bold{10}:34.
}

\examples{
## plot of individuals for objects of class 'rcc'
# ----------------------------------------------------
dev.off()
data(nutrimouse)
X <- nutrimouse$lipid
Y <- nutrimouse$gene
nutri.res <- rcc(X, Y, ncomp = 3, lambda1 = 0.064, lambda2 = 0.008)

plotArrow(nutri.res)

# names indicate genotype
plotArrow(nutri.res,
group = nutrimouse$genotype, ind.names = nutrimouse$genotype)


plotArrow(nutri.res, group = nutrimouse$genotype,
legend = TRUE)


\dontrun{
## plot of individuals for objects of class 'pls' or 'spls'
# ----------------------------------------------------
data(liver.toxicity)
X <- liver.toxicity$gene
Y <- liver.toxicity$clinic
toxicity.spls <- spls(X, Y, ncomp = 3, keepX = c(50, 50, 50),
keepY = c(10, 10, 10))

#default
plotArrow(toxicity.spls)


# colors indicate time of necropsy, text is the dose
plotArrow(toxicity.spls,  group = liver.toxicity$treatment[, 'Time.Group'],
ind.names  = liver.toxicity$treatment[, 'Dose.Group'],
legend = TRUE)

# colors indicate time of necropsy, text is the dose, label at start of arrow
plotArrow(toxicity.spls,  group = liver.toxicity$treatment[, 'Time.Group'],
ind.names  = liver.toxicity$treatment[, 'Dose.Group'],
legend = TRUE, position.names = 'start')

## variable representation for objects of class 'sgcca' (or 'rgcca')
# ----------------------------------------------------
data(nutrimouse)
Y = unmap(nutrimouse$diet)
data = list(gene = nutrimouse$gene, lipid = nutrimouse$lipid, Y = Y)
design1 = matrix(c(0,1,1,1,0,1,1,1,0), ncol = 3, nrow = 3, byrow = TRUE)
nutrimouse.sgcca <- wrapper.sgcca(X = data,
design = design1,
penalty = c(0.3, 0.5, 1),
ncomp = 3,
scheme = "centroid")

# default style: same color for all samples
plotArrow(nutrimouse.sgcca)


plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot')

# ind.names to visualise the unique individuals
plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = TRUE)

# ind.names to visualise the unique individuals
plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = TRUE,position.names   = 'start')

plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = TRUE,position.names   = 'end')

# ind.names indicates the diet
plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = nutrimouse$diet, position.names= 'start')

# ind.names to visualise the unique individuals, start position
plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = TRUE, position.names   = 'start')

# end position
plotArrow(nutrimouse.sgcca, group = nutrimouse$diet, legend =TRUE,
title = 'my plot', ind.names = TRUE, position.names   = 'end')


## variable representation for objects of class 'sgccda'
# ----------------------------------------------------
# Note: the code differs from above as we use a 'supervised' GCCA analysis
data(nutrimouse)
Y = nutrimouse$diet
data = list(gene = nutrimouse$gene, lipid = nutrimouse$lipid)
design1 = matrix(c(0,1,0,1), ncol = 2, nrow = 2, byrow = TRUE)

nutrimouse.sgccda1 <- wrapper.sgccda(X = data,
Y = Y,
design = design1,
ncomp = 2,
keepX = list(gene = c(10,10), lipid = c(15,15)),
scheme = "centroid")


#  default colors correspond to outcome Y
plotArrow(nutrimouse.sgccda1)


# with legend and title and indiv ID
plotArrow(nutrimouse.sgccda1,  legend = TRUE, title = 'my sample plot',
ind.names = TRUE, position.names = 'start')

}
}

\keyword{multivariate}
\keyword{hplot}
\keyword{dplot}
\value{none}
