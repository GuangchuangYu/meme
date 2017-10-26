
##' convert meme to grob object
##'
##'
##' @title memeGrob
##' @param x meme object
##' @return grob object
##' @export
##' @examples
##' f <- system.file("angry8.jpg", package="meme")
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

    if (is.null(x$bgcolor)) {
        return(gList(x$imageGrob, upperGrob, lowerGrob))
    }

    gp$col <- x$bgcolor
    upperBg <- shadowtext(toupper(x$upper), gp = gp, vp =  viewport(y=1-vjust), x$r)
    lowerBg <- shadowtext(toupper(x$lower), gp = gp, vp =  viewport(y=vjust), x$r)

    gList(x$imageGrob, upperBg, lowerBg, upperGrob, lowerGrob)
}


shadowtext <- function(text, gp = gpar(), vp = viewport(), r=0.01) {
    theta <- seq(pi/8, 2*pi, length.out=16)

    txtList <- lapply(theta, function(i) {
        vp$x <- vp$x * (1 + cos(i) * r)
        vp$y <- vp$y * (1 + sin(i) * r)
        textGrob(text, gp = gp, vp = vp)
    })
    do.call(gList, txtList)
}


