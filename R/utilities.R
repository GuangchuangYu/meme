## convert pixel to inch
px2in <- function(x) {
    x * 0.010417
}

##' aspect ratio of meme
##'
##'
##' @title asp
##' @param x meme object
##' @return asp ratio
##' @export
##' @author guangchuang yu
##' @examples
##' f <- system.file("icon.png", package="meme")
##' x <- meme(f, "meme", "produced by meme package")
##' asp(x)
asp <- function(x) {
    x$height/x$width
}

## ##' @method length meme
## ##' @export
## length.meme <- function(x) {
##     return(1)
## }

##' @importFrom ggplot2 aes
##' @export
ggplot2::aes

##' @importFrom ggplot2 ggsave
##' @export
ggplot2::ggsave
