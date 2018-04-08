<!-- README.md is generated from README.Rmd. Please edit that file -->
meme: Create memes in R
=======================

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/meme?color=green)](https://cran.r-project.org/package=meme) ![](http://cranlogs.r-pkg.org/badges/grand-total/meme?color=green) ![](http://cranlogs.r-pkg.org/badges/meme?color=green) ![](http://cranlogs.r-pkg.org/badges/last-week/meme?color=green)

Authors
-------

Guangchuang YU <https://guangchuangyu.github.io>

School of Public Health, The University of Hong Kong

[![saythanks](https://img.shields.io/badge/say-thanks-ff69b4.svg)](https://saythanks.io/to/GuangchuangYu) [![](https://img.shields.io/badge/follow%20me%20on-微信-green.svg?style=flat)](https://guangchuangyu.github.io/blog_images/biobabble.jpg) [![](https://img.shields.io/badge/打赏-支付宝/微信-green.svg?style=flat)](https://guangchuangyu.github.io/blog_images/pay_qrcode.png)

Installation
------------

Get the released version from CRAN:

``` r
install.packages("meme")
```

Or the development version from github:

``` r
## install.packages("devtools")
devtools::install_github("GuangchuangYu/meme")
```

Vignette
--------

``` r
## after installing the package
vignette("meme", package="meme")
```

Example
-------

``` r
library(meme)
u <- system.file("angry8.jpg", package="meme")
meme(u, "code", "all the things!")
```

![](https://guangchuangyu.github.io/blog_images/R/meme/shadowtext.png)
