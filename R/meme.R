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
##' @author guangchuang yu
meme <- function(img, upper="", lower="", size="auto", color="white", font="Helvetica", plot=TRUE) {
    x <- image_read(img)
    info <- image_info(x)

    if (size == "auto") {
        size <- info$height/250
    }

    gp <- gpar(col = color, fontfamily = font, cex = size)
    upperGrob <- textGrob(toupper(upper), gp = gp, vp = viewport(y=.8))
    lowerGrob <- textGrob(toupper(lower), gp = gp, vp = viewport(y=.1))

    meme <- gList(rasterGrob(x), upperGrob, lowerGrob)

    if (plot) {
        dev.new(width=7, height=7*info$height/info$width)
        grid.draw(meme)
    }

    res <- list(img = img, gList=meme, width = info$width, height = info$height, upper=upper, lower=lower)
    class(res) <- "meme"
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
##' @export
##' @author guangchuang yu
meme_save <- function(x, file="meme.png", device=NULL, dpi = 300) {
    if (!is(x, "meme")) {
        stop("x should be an instance of 'meme'")
    }
    dev <- plot_dev(device, file, dpi = dpi)
    dev(file = file, width = x$width * 0.010417, height = x$height * 0.010417)
    on.exit(utils::capture.output(grDevices::dev.off()))
    grid.draw(x$gList)
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
