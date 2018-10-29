
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dplyrbench

``` r
dplyrbench::setup_libs()
```

``` r
library(dplyrbench)

# non hybrid
benchs({
    mean_ <- function(...) mean(...)
    df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g)
  }, 
  summarise(df, x = mean_(x))
)
#> # A tibble: 3 x 15
#>   version expression   min  mean median   max `itr/sec` mem_alloc  n_gc
#>   <chr>   <chr>      <dbl> <dbl>  <dbl> <dbl>     <dbl>     <dbl> <dbl>
#> 1 0.7.7   summarise… 1.71  1.71   1.71  1.71      0.586   5168736    46
#> 2 0.8.0-… summarise… 1.53  1.53   1.53  1.53      0.652    862208    40
#> 3 0.8.0-… summarise… 0.628 0.628  0.628 0.628     1.59     862208     8
#> # ... with 6 more variables: n_itr <int>, total_time <dbl>, result <list>,
#> #   memory <list>, time <list>, gc <list>

# hybrid
benchs(
  df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g),
  summarise(df, x = mean(x))
)
#> # A tibble: 3 x 15
#>   version expression     min   mean  median    max `itr/sec` mem_alloc
#>   <chr>   <chr>        <dbl>  <dbl>   <dbl>  <dbl>     <dbl>     <dbl>
#> 1 0.7.7   summarise… 0.0132  0.0139 0.0138  0.0156      72.0    905080
#> 2 0.8.0-… summarise… 0.00940 0.0102 0.0101  0.0117      97.9    818952
#> 3 0.8.0-… summarise… 0.00924 0.0100 0.00997 0.0112      99.6    818952
#> # ... with 7 more variables: n_gc <dbl>, n_itr <int>, total_time <dbl>,
#> #   result <list>, memory <list>, time <list>, gc <list>
# partial hybrid
benchs(
  df <- tibble(x = rnorm(1e6), g = rep(1:1e5, 10)) %>% group_by(g),
  summarise(df, x = sum(x) / n())
)
#> # A tibble: 3 x 15
#>   version expression   min  mean median   max `itr/sec` mem_alloc  n_gc
#>   <chr>   <chr>      <dbl> <dbl>  <dbl> <dbl>     <dbl>     <dbl> <dbl>
#> 1 0.7.7   summarise… 1.28  1.28   1.28  1.28      0.781   5145496    36
#> 2 0.8.0-… summarise… 1.45  1.45   1.45  1.45      0.690    856104    38
#> 3 0.8.0-… summarise… 0.487 0.488  0.488 0.489     2.05     856104    10
#> # ... with 6 more variables: n_itr <int>, total_time <dbl>, result <list>,
#> #   memory <list>, time <list>, gc <list>
```
