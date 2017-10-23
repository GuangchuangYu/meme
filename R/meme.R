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
##' @param plot boolean, one of TRUE or FALSE
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
##' \dontrun{
##' u <- "http://www.happyfamilyneeds.com/wp-content/uploads/2017/08/angry8.jpg"
##' meme(u, "code", "all the things!")
##' }
##' @author guangchuang yu
meme <- function(img, upper="", lower="", size="auto", color="white", font="Helvetica", plot=TRUE) {
    x <- image_read(img)
    info <- image_info(x)

    imageGrob <- rasterGrob(x)

    res <- list(img = img, imageGrob = imageGrob,
                width = info$width, height = info$height,
                upper=upper, lower=lower,
                size = size, color = color, font = font)
    class(res) <- "meme"

    if (plot) {
        plot(res)
    }

    invisible(res)
}

##' save meme plot
##'
##'
##' @title meme_save
##' @param x meme output
##' @param file output file
##' @param device graphic device
##' @param dpi dpi of the figure
##' @return NULL
##' @importFrom methods is
##' @importFrom graphics plot
##' @export
##' @author guangchuang yu
meme_save <- function(x, file="meme.png", device=NULL, dpi = 300) {
    if (!is(x, "meme")) {
        stop("x should be an instance of 'meme'")
    }
    dev <- plot_dev(device, file, dpi = dpi)
    dev(file = file, width = x$width * 0.010417, height = x$height * 0.010417)
    on.exit(utils::capture.output(grDevices::dev.off()))
    plot(x, dev.new = FALSE)
    invisible()
}

plot_dev <- getFromNamespace("plot_dev", "ggplot2")


##' @method print meme
##' @export
print.meme <- function(x, ...) {
    msg <- paste0("meme:\n  image souce:  ", x$img,
                  "\n  caption:\n    upper:  ", x$upper,
                  "\n    lower:  ", x$lower)
    #"\n--> use `meme_save()` to export the object to figure")
    message(msg)
}


##' plot method for meme object
##'
##'
##' @method plot meme
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
plot.meme <- function(x, size = NULL, color = NULL, font = NULL, upper = NULL, lower = NULL, dev.new = TRUE, vjust=.1, ...) {
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

    gp <- gpar(col = color, fontfamily = font, cex = size)
    upperGrob <- textGrob(toupper(upper), gp = gp, vp = viewport(y=1-vjust))
    lowerGrob <- textGrob(toupper(lower), gp = gp, vp = viewport(y=vjust))

    meme <- gList(x$imageGrob, upperGrob, lowerGrob)

    if (is.null(knitr::opts_knit$get("out.format"))) {
        if (dev.new) {
            if (!is.null(dev.list()))
                tryCatch(dev.off(), error = function(e) NULL)
            dev.new(width=7, height=7*x$height/x$width)
        }
    }
    grid.draw(meme)
}

##' aspect ratio of meme
##'
##'
##' @title asp
##' @param x meme object
##' @return asp ratio
##' @export
##' @author guangchuang yu
asp <- function(x) {
    x$height/x$width
}
