##' create meme
##'
##'
##' @title meme
##' @param img path or url
##' @param upper upper text
##' @param lower lower text
##' @param size size of text
##' @param color color of text
##' @param font font family of text
##' @param vjust vertical adjustment of captions
##' @return grob object
##' @importFrom magick image_read
##' @importFrom magick image_info
##' @importFrom grid textGrob
##' @importFrom grid rasterGrob
##' @importFrom grid gpar
##' @importFrom grid viewport
##' @importFrom grid grid.draw
##' @importFrom grid gList
##' @importFrom grDevices dev.new
##' @export
##' @examples
##' f <- system.file("icon.png", package="meme")
##' meme(f, "code", "all the things!", size=3)
##' @author guangchuang yu
meme <- function(img, upper="", lower="", size="auto", color="white", font="Helvetica", vjust = .1) {
    x <- image_read(img)
    info <- image_info(x)

    imageGrob <- rasterGrob(x)

    p <- structure(
        list(img = img, imageGrob = imageGrob,
             width = info$width, height = info$height,
             upper=upper, lower=lower,
             size = size, color = color,
             font = font, vjust = vjust),
        class = c("meme", "recordedplot"))
    p
}

##' save meme plot
##'
##'
##' @title meme_save
##' @param x meme output
##' @param file output file
##' @param width width of graph
##' @param height height of graph
##' @param ... additional arguments for ggsave
##' @return NULL
##' @importFrom methods is
##' @importFrom graphics plot
##' @importFrom ggplot2 ggsave
##' @export
##' @examples
##' f <- system.file("icon.png", package="meme")
##' x <- meme(f, "code", "all the things!")
##' outfile <- tempfile(fileext = ".png")
##' meme_save(x, outfile)
##' @author guangchuang yu
meme_save <- function(x, file, width = NULL, height = NULL, ...) {
    if (!is(x, "meme")) {
        stop("x should be an instance of 'meme'")
    }

    if (is.null(width) && is.null(height)) {
        width <- px2in(x$width)
        height <- px2in(x$height)
    } else if (is.null(width)) {
        width <- height / asp(x)
    } else {
        height <- width * asp(x)
    }

    ggsave(filename = file, plot = x,
           width = width,
           height = height,
           ...)
}


##' Setting meme parameter
##'
##'
##' @rdname meme-add
##' @param e1 meme object
##' @param e2 aes()
##' @method + meme
##' @export
##' @examples
##' f <- system.file("icon.png", package="meme")
##' meme(f, "code", "all the things!") + aes(color="firebrick")
"+.meme" <- function(e1, e2) {
    params <- as.list(e2)
    names(params)[names(params) == "colour"] <- "color"
    params <- params[names(params) %in% names(e1)]
    for (i in seq_along(params))
        e1[names(params)[i]] <- as.character(params[[i]])
    e1
}

## ##' @rdname meme-add
## ##' @export
## "%+%" <- `+.meme`


## ## @method print meme
## ## @export
## print.meme <- function(x, ...) {
##     msg <- paste0("meme:\n  image souce:  ", x$img,
##                   "\n  caption:\n    upper:  ", x$upper,
##                   "\n    lower:  ", x$lower)
##     message(msg)
## }


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
##' @param ... other arguments not used by this method
##' @importFrom grDevices dev.list
##' @importFrom grDevices dev.off
##' @importFrom grDevices dev.size
##' @importFrom grDevices dev.interactive
##' @importFrom grid grid.newpage
##' @examples
##' f <- system.file("icon.png", package="meme")
##' x <- meme(f, "code", "all the things!")
##' print(x)
print.meme <- function(x, size = NULL, color = NULL, font = NULL, upper = NULL, lower = NULL, vjust=NULL, ...) {
    if (is.null(upper))
        upper <- x$upper
    if (is.null(lower))
        lower <- x$lower

    if (is.null(size))
        size <- x$size
    if (is.null(color))
        color <- x$color
    if (is.null(font))
        font <- x$font

    if (size == "auto") {
        size <- x$height/250
    }
    if (is.null(vjust))
        vjust <- x$vjust

    ds <- dev.size() # w & h
    h <- ds[1] * asp(x)
    vjust <- (h*vjust + (ds[2]-h)/2)/ds[2]

    gp <- gpar(col = color, fontfamily = font, cex = size)
    upperGrob <- textGrob(toupper(upper), gp = gp, vp = viewport(y=1-vjust))
    lowerGrob <- textGrob(toupper(lower), gp = gp, vp = viewport(y=vjust))
    meme <- gList(x$imageGrob, upperGrob, lowerGrob)

    if (dev.interactive())
        grid.newpage()

    grid.draw(meme)
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
