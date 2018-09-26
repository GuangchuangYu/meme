##' print method for meme object
##'
##'
##' @method print meme
##' @export
##' @param x meme object
##' @param size size of text
##' @param color color of text
##' @param font font family of text
##' @param upper upper text
##' @param lower lower text
##' @param vjust vertical adjustment ratio
##' @param bgcolor background color of shadow text
##' @param r ratio for shadow text
##' @param newpage draw new (empty) page first?
##' @param vp viewport to draw plot in
##' @param newdev open new graphic device?
##' @param ... other arguments not used by this method
##' @importFrom grDevices dev.list
##' @importFrom grDevices dev.off
##' @importFrom grDevices dev.size
##' @importFrom grDevices dev.interactive
##' @importFrom grid grid.newpage
##' @importFrom grid pushViewport
##' @importFrom grid upViewport
##' @importFrom grid seekViewport
##' @examples
##' f <- system.file("angry8.jpg", package="meme")
##' x <- meme(f, "code", "all the things!", font = "Helvetica")
##' print(x)
print.meme <- function(x, size = NULL, color = NULL, font = NULL,
                       upper = NULL, lower = NULL, vjust=NULL,
                       bgcolor = NULL, r = NULL,
                       newpage = is.null(vp), vp = NULL, newdev = FALSE, ...) {

    ## R CMD check will throw error when using default font 'Impact' in Rd examples

    x <- x + list(size = size, color = color,
                  font = font, vjust = vjust,
                  bgcolor = bgcolor, r = r,
                  upper = upper, lower = lower)

    grob <- as.gList(x)

    if (newdev) meme_dev(x)

    ## if (dev.interactive())
    if (newpage) grid.newpage()

    if (is.null(vp)) {
        grid.draw(grob)
    } else {
        if (is.character(vp)) seekViewport(vp) else pushViewport(vp)
        grid.draw(grob)
        upViewport()
    }

    invisible(x)
}

##' @rdname print.meme
##' @method plot meme
##' @export
plot.meme <- print.meme


##' @method grid.draw meme
##' @export
grid.draw.meme <- function(x, recording = TRUE) {
    print(x)
}

##' grid.echo method for meme object
##'
##' using the solution <https://stackoverflow.com/a/18551959/3844636>
##' to not importing grid.echo generics from gridGraphics for easy installation,
##' since gridGraphics has system requirement of ImageMagick <https://github.com/cran/gridGraphics/blob/master/DESCRIPTION#L14>.
##'
##' this method is just a hack for making cowplot to support meme object, and not used elsewhere.
##'
##' @title grid.echo.meme
##' @param x meme object
##' @param newpage not use in this method
##' @param prefix not use in this method
##' @return meme object
##' @method grid.echo meme
##' @importFrom gridGraphics grid.echo
## @export grid.echo.meme
##' @author guangchuang yu
grid.echo.meme <- function(x = NULL, newpage = TRUE, prefix = NULL) {
    meme_dev(x)
    grid.draw(x)
}


meme_dev <- function(x) {
    if (!is.null(dev.list()))
        tryCatch(dev.off(), error = function(e) NULL)
    dev.new(width=7, height=7*x$height/x$width, noRStudioGD = TRUE)
}

