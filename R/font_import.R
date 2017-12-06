##' @rdname font-import
##' @export
font_pokemon <- function() {
    font_import2('pokemon')
}

font_import2 <- function(font_dir) {
    path <- system.file("fonts", font_dir, package="meme")
    font_import(path)
}

##' load fonts
##'
##'
##' @title font_pokemon
##' @rdname font-import
##' @param path folder of fonts
##' @return NULL
##' @importFrom sysfonts font_add
##' @importFrom showtext showtext_auto
##' @export
##' @author Guangchuang Yu
font_import <- function(path='.') {
    wd <- getwd()
    setwd(path)
    fonts <- list.files(path, pattern="ttf")
    font_names <- sub("\\..*", "", fonts)
    for (i in seq_along(fonts)) {
        font_add(font_names[i], fonts[i])
    }
    showtext_auto()
    setwd(wd)
    message("font ", paste(font_names, collapse=", "), " loaded...")
}
