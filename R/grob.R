
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
##' @author Guangchuang Yu
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

    upperGrob <- shadowtext(toupper(x$upper), gp = gp,
                            vp = viewport(y = 1-vjust),
                            bgcolor = x$bgcolor, r = x$r, vjust=1)

    lowerGrob <- shadowtext(toupper(x$lower), gp = gp,
                            vp = viewport(y = vjust),
                            bgcolor = x$bgcolor, r = x$r, vjust=0)

    gList(x$imageGrob, upperGrob, lowerGrob)
}

##' @importFrom grid unit
shadowtext <- function(text, gp = gpar(), vp = viewport(), bgcolor = NULL, r=0.2, vjust=.5) {
    upperGrob <- textGrob(text, gp = gp, vp = vp, vjust = vjust)

    if (is.null(bgcolor)) return(upperGrob)

    gp$col <- bgcolor
    theta <- seq(pi/8, 2*pi, length.out=16)
    ovp <- vp
    char <- substring(text, 1, 1)

    bgList <- lapply(theta, function(i) {
        vp <- ovp
        vp$x <- vp$x + unit(cos(i) * r, "strwidth", data = char)
        vp$y <- vp$y + unit(sin(i) * r, "strheight", data = char)
        textGrob(text, gp = gp, vp = vp, vjust = vjust)
    })

    bgGrob <- do.call(gList, bgList)
    grobs <- gList(bgGrob, upperGrob)
    gTree(children = grobs)
}


