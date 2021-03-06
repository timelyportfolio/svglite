% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SVG.R
\name{svglite}
\alias{svglite}
\title{An SVG Graphics Driver}
\usage{
svglite(file = "Rplots.svg", width = 10, height = 8, bg = "white",
  pointsize = 12, standalone = TRUE, system_fonts = list(),
  user_fonts = list())
}
\arguments{
\item{file}{The file where output will appear.}

\item{height, width}{Height and width in inches.}

\item{bg}{Default background color for the plot (defaults to "white").}

\item{pointsize}{Default point size.}

\item{standalone}{Produce a standalone svg file? If \code{FALSE}, omits
xml header and default namespace.}

\item{system_fonts}{Named list of font names to be aliased with
fonts installed on your system. If unspecified, the R default
families \code{sans}, \code{serif}, \code{mono} and \code{symbol}
are aliased to the family returned by
\code{\link[gdtools]{match_family}()}.}

\item{user_fonts}{Named list of fonts to be aliased with font files
provided by the user rather than fonts properly installed on the
system. The aliases can be fonts from the fontquiver package,
strings containing a path to a font file, or a list containing
\code{name} and \code{file} elements with \code{name} indicating
the font alias in the SVG output and \code{file} the path to a
font file.}
}
\description{
This function produces graphics compliant to the current w3 svg XML
standard. The driver output is currently NOT specifying a DOCTYPE DTD.
}
\details{
svglite provides two ways of controlling fonts: system fonts
aliases and user fonts aliases. Supplying a font alias has two
effects. First it determines the \code{font-family} property of all
text anchors in the SVG output. Secondly, the font is used to
determine the dimensions of graphical elements and has thus an
influence on the overall aspect of the plots. This means that for
optimal display, the font must be available on both the computer
used to create the svg, and the computer used to render the
svg. See the \code{fonts} vignette for more information.
}
\examples{
# Save to file
svglite("Rplots.svg")
plot(1:11, (-5:5)^2, type = 'b', main = "Simple Example")
dev.off()

# Supply system font aliases. First check the font can be located:
gdtools::match_family("Verdana")

# Then supply a list of aliases:
fonts <- list(sans = "Verdana", mono = "Times New Roman")
svglite("Rplots.svg", system_fonts = fonts)
plot.new()
text(0.5, 0.5, "Some text", family = "mono")
dev.off()

# If you need support for non-latin characters, choose fonts with
# good Unicode coverage. "Arial Unicode MS" is available on macOS
# and Windows systems (if MS Office is installed on the latter):
svglite("Rplots.svg", system_fonts = list(sans = "Arial Unicode MS"))
plot.new()
text(0.5, 0.5, "正規分布")
dev.off()

# To supply user font aliases, use either fontquiver:
fonts <- fontquiver::font_families("Liberation")

# Or create yourself a list of fonts. First create a font file
# object, which is a list with name and ttf elements:
myfont <- list(alias = "Some Font Serif", file = "myfont.ttf")
myotherfont <- list(alias = "Other Font Mono", file = "myotherfont.ttf")

# Then create a named tree with R font families (sans, serif, mono,
# symbol) in the first level and R faces in the second (plain,
# itali bold, bolditalic, symbol).
fonts <- list(
  sans = list(plain = myfont),
  mono = list(italic = myotherfont),
  `Foo Bar` = list(plain = myfont, italic = myotherfont),
  `Foo Baz` = list(plain = "no_aliasing.ttf")
)

# This will cause the sans/plain, mono/italic and Foo
# Bar/plain/italic faces to be aliased with the font names supplied
# in the font objects. Also the supplied fonts will be used to
# compute the metrics of the graphical elements.

\dontrun{
ss <- svgstring(user_fonts = fonts)
plot(1:2, main = "Simple Example")
text(0.5, 0.5, family = "Foo Bar", font = 3)
dev.off()
ss()
}
}
\author{
This driver was written by T Jake Luciani
  \email{jakeluciani@yahoo.com} 2012: updated by Matthieu Decorde
  \email{matthieu.decorde@ens-lyon.fr}
}
\references{
\emph{W3C Scalable Vector Graphics (SVG)}:
  \url{http://www.w3.org/Graphics/SVG/Overview.htm8}
}
\seealso{
\code{\link{pictex}}, \code{\link{postscript}}, \code{\link{Devices}}
}
\keyword{device}

