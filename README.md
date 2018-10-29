
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dplyrbench

``` r
dplyrbench::setup_libs()
```

``` r
library(bench)
library(purrr)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(dplyrbench)

# non hybrid
benchs({
    mean_ <- function(...) mean(...)
    df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g)
  }, 
  summarise(df, x = mean_(x))
)
#> # A tibble: 3 x 11
#>   version expression   min  mean median   max `itr/sec` mem_alloc  n_gc
#>   <chr>   <chr>      <dbl> <dbl>  <dbl> <dbl>     <dbl>     <dbl> <dbl>
#> 1 0.7.7   summarise… 1.75  1.75   1.75  1.75      0.572   5168736    45
#> 2 0.8.0-… summarise… 1.55  1.55   1.55  1.55      0.645    862208    41
#> 3 0.8.0-… summarise… 0.626 0.626  0.626 0.626     1.60     862208     8
#> # ... with 2 more variables: n_itr <int>, total_time <dbl>

# hybrid
benchs(
  df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g),
  summarise(df, x = mean(x))
)
#> # A tibble: 3 x 11
#>   version expression     min    mean  median    max `itr/sec` mem_alloc
#>   <chr>   <chr>        <dbl>   <dbl>   <dbl>  <dbl>     <dbl>     <dbl>
#> 1 0.7.7   summarise… 0.0133  0.0141  0.0138  0.0162      71.2    905080
#> 2 0.8.0-… summarise… 0.00921 0.00991 0.00988 0.0109     101.     818952
#> 3 0.8.0-… summarise… 0.00939 0.0102  0.00994 0.0123      98.2    818952
#> # ... with 3 more variables: n_gc <dbl>, n_itr <int>, total_time <dbl>
# partial hybrid
benchs(
  df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g),
  summarise(df, x = sum(x) / n())
)
#> # A tibble: 3 x 11
#>   version expression   min  mean median   max `itr/sec` mem_alloc  n_gc
#>   <chr>   <chr>      <dbl> <dbl>  <dbl> <dbl>     <dbl>     <dbl> <dbl>
#> 1 0.7.7   summarise… 1.26  1.26   1.26  1.26      0.793   5145496    36
#> 2 0.8.0-… summarise… 1.43  1.43   1.43  1.43      0.699    856104    38
#> 3 0.8.0-… summarise… 0.490 0.490  0.490 0.490     2.04     856104    10
#> # ... with 2 more variables: n_itr <int>, total_time <dbl>
```
