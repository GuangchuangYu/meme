<!-- README.md is generated from README.Rmd. Please edit that file -->
`meme`
------

Call `meme` to add meme captions:

``` r
library(meme)
u <- "http://www.happyfamilyneeds.com/wp-content/uploads/2017/08/angry8.jpg"
meme(u, "code", "all the things!")
```

![](docs/Figs/unnamed-chunk-2-1.png)

`meme_save`
-----------

The `meme` output can be save as an object, and can be exported to file using `meme_save`, (similar to `ggsave` :smiley:):

``` r
u2 <- "http://i0.kym-cdn.com/entries/icons/mobile/000/000/745/success.jpg"
x <- meme(u2, "please", "tell me more")
meme_save(x, file="docs/Figs/meme.png")
```

<img src="docs/Figs/meme.png" width="672"/>

`plot` method
-------------

Users can `plot` the `meme` output and change the caption or other parameters in real time.

``` r
plot(x, size = 2, "happy friday!", "wait, sorry, it's monday", color = "firebrick", font = "Courier")
```

![](docs/Figs/unnamed-chunk-4-1.png)

`+` method
----------

Instead of using parameters explictely, Users can use `+ aes()` to set the plot parameter:

``` r
x + aes(upper = "#barbarplots",
        lower = "friends don't let friends make bar plots",
        color = firebrick, font = Courier, size=1.5)
```

![](docs/Figs/unnamed-chunk-5-1.png)

or using `+ list()`. The following command will also generate the figure displayed above.

``` r
x + list(upper = "#barbarplots",
        lower = "friends don't let friends make bar plots",
        color = "firebrick", font = "Courier", size=1.5)
```

multi-language support
----------------------

I didn't do anything about it. Multi-language was supported internally. Just simply select a font for your language.

``` r
meme(u, "卧槽", "听说你想用中文", font="STHeiti")
```

![](docs/Figs/unnamed-chunk-7-1.png)
