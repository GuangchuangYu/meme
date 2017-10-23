
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
asp <- function(x) {
    x$height/x$width
}

##' @importFrom ggplot2 aes
##' @export
ggplot2::aes

