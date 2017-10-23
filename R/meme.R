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
##' u <- "http://www.happyfamilyneeds.com/wp-content/uploads/2017/08/angry8.jpg"
##' meme(u, "code", "all the things!")
##' @author guangchuang yu
meme <- function(img, upper="", lower="", size="auto", color="white", font="Helvetica") {
    x <- image_read(img)
    info <- image_info(x)

    imageGrob <- rasterGrob(x)

    p <- structure(
        list(img = img, imageGrob = imageGrob,
             width = info$width, height = info$height,
             upper=upper, lower=lower,
             size = size, color = color, font = font),
        class = "meme")
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
##' @author guangchuang yu
meme_save <- function(x, file, width = NULL, height = NULL, ...) {
    if (!is(x, "meme")) {
        stop("x should be an instance of 'meme'")
    }

    if (is.null(width))
        width <- px2in(x$width)
    if (is.null(height))
        height <- px2in(x$height)

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
##' @param dev.new wheter open new device
##' @param vjust vertical adjustment ratio
##' @param ... other arguments not used by this method
##' @importFrom grDevices dev.list
##' @importFrom grDevices dev.off
##' @importFrom grDevices dev.size
print.meme <- function(x, size = NULL, color = NULL, font = NULL, upper = NULL, lower = NULL, dev.new = TRUE, vjust=.1, ...) {
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

    ds <- dev.size() # w & h
    h <- ds[1] * asp(x)
    vjust <- (h*vjust + (ds[2]-h)/2)/ds[2]

    gp <- gpar(col = color, fontfamily = font, cex = size)
    upperGrob <- textGrob(toupper(upper), gp = gp, vp = viewport(y=1-vjust))
    lowerGrob <- textGrob(toupper(lower), gp = gp, vp = viewport(y=vjust))
    meme <- gList(x$imageGrob, upperGrob, lowerGrob)

    ## if (is.null(knitr::opts_knit$get("out.format"))) {
    ##     if (dev.new) {
    ##         if (!is.null(dev.list()))
    ##             tryCatch(dev.off(), error = function(e) NULL)
    ##         dev.new(width=7, height=7*x$height/x$width, noRStudioGD = TRUE)
    ##     }
    ## }

    grid.draw(meme)
    invisible(x)
}

##' @method grid.draw meme
##' @export
grid.draw.meme <- function(x, recording = TRUE) {
    print(x)
}

##' @rdname print.meme
##' @method plot meme
##' @export
plot.meme <- print.meme

