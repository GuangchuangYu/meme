<!-- README.md is generated from README.Rmd. Please edit that file -->

# meme: Create memes in R

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/meme?color=green)](https://cran.r-project.org/package=meme)
![](http://cranlogs.r-pkg.org/badges/grand-total/meme?color=green)
![](http://cranlogs.r-pkg.org/badges/meme?color=green)
![](http://cranlogs.r-pkg.org/badges/last-week/meme?color=green)

The word ‘Meme’ was originated from the book, ‘The Selfish Gene’,
authored by Richard Dawkins (1976). It is a unit of culture that is
passed from one generation to another and correlates to the gene, the
unit of physical heredity. The internet memes are captioned photos that
are intended to be funny, ridiculous. Memes behave like infectious
viruses and travel from person to person quickly through social media.
The ‘meme’ package allows users to make custom memes.

## Authors

Guangchuang YU <https://yulab-smu.top>

School of Basic Medical Sciences, Southern Medical University

## Installation

Get the released version from CRAN:

``` r
install.packages("meme")
```

Or the development version from github:

``` r
## install.packages("devtools")
devtools::install_github("GuangchuangYu/meme")
```

## Vignette

``` r
## after installing the package
vignette("meme", package="meme")
```

## Example

``` r
library(meme)
u <- system.file("angry8.jpg", package="meme")
meme(u, "code", "all the things!")
```

![](https://guangchuangyu.github.io/blog_images/R/meme/shadowtext.png)
