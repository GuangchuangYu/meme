# meme: Create memes in R


[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/meme?color=green)](https://cran.r-project.org/package=meme)
![](http://cranlogs.r-pkg.org/badges/grand-total/meme?color=green)
![](http://cranlogs.r-pkg.org/badges/meme?color=green)
![](http://cranlogs.r-pkg.org/badges/last-week/meme?color=green)
[![gitter](https://img.shields.io/badge/GITTER-join%20chat-green.svg)](https://gitter.im/GuangchuangYu/Bioinformatics)


## Authors

Guangchuang YU <https://guangchuangyu.github.io>

School of Public Health, The University of Hong Kong

## Installation

Get the released version from CRAN:

```r
install.packages("meme")
```

Or the development version from github:

```r
## install.packages("devtools")
devtools::install_github("GuangchuangYu/meme")
```


## Vignette

```r
## after installing the package
vignette("meme", package="meme")
```

## Example

```r
library(meme)
u <- system.file("angry8.jpg", package="meme")
meme(u, "code", "all the things!")
```

![](https://guangchuangyu.github.io/blog_images/R/meme/shadowtext.png)
