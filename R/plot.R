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
##' @param newpage draw new (empty) page first?
##' @param vp viewport to draw plot in
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
##' x <- meme(f, "code", "all the things!")
##' print(x)
print.meme <- function(x, size = NULL, color = NULL, font = NULL,
                       upper = NULL, lower = NULL, vjust=NULL,
                       newpage = is.null(vp), vp = NULL, ...) {

    params <- list(size = size, color = color,
                   font = font, vjust = vjust,
                   upper = upper, lower = lower)
    params <- params[!sapply(params, is.null)]

    x <- modifyList(x, params)
    grob <- as.gList(x)

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


##' @method grid.echo meme
##' @importFrom gridGraphics grid.echo
##' @export
grid.echo.meme <- function(x = NULL, newpage = TRUE, prefix = NULL) {
    if (!is.null(dev.list()))
        tryCatch(dev.off(), error = function(e) NULL)
    dev.new(width=7, height=7*x$height/x$width, noRStudioGD = TRUE)

    grid.draw(x)
}

