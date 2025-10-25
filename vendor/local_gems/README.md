# Local shim gems

The files in this directory provide tiny stand-ins for the gems that
normally come from rubygems.org (`jekyll`, `github-pages`, `jekyll-feed`,
`jekyll-sitemap`, `hawkins`, and `wdm`). They exist solely so that
`bundle install` succeeds in environments without outbound network access.

Set `ACADEMIC_PAGES_REAL_GEMS=true` before running `bundle install` to use
the upstream gems instead of these shims once network access is available.
