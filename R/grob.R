
##' convert meme to grob object
##'
##'
##' @title memeGrob
##' @param x meme object
##' @return grob object
##' @export
##' @examples
##' f <- system.file("icon.png", package="meme")
##' x <- meme(f, "code", "all the things!")
##' memeGrob(x)
##' @author guangchuang yu
memeGrob <- function(x) {
    as.gTree(x)
}


##' @importFrom grid gTree
as.gTree <- function(x) {
    ## grid::grid.grabExpr(gridGraphics::grid.echo(x))
    gTree(children = as.gList(x))
}


##' @importFrom grid gList
as.gList <- function(x) {
    if (x$size == "auto") {
        x$size <- x$height/250
    }

    ds <- dev.size() # w & h
    h <- ds[1] * asp(x)
    vjust <- (h * x$vjust + (ds[2]-h)/2)/ds[2]

    gp <- gpar(col = x$color, fontfamily = x$font, cex = x$size)
    upperGrob <- textGrob(toupper(x$upper), gp = gp, vp = viewport(y=1-vjust))
    lowerGrob <- textGrob(toupper(x$lower), gp = gp, vp = viewport(y=vjust))
    gList(x$imageGrob, upperGrob, lowerGrob)
}


