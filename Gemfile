# frozen_string_literal: true

use_remote_gems = ENV["ACADEMIC_PAGES_REAL_GEMS"] == "true"

if use_remote_gems
  source "https://rubygems.org"

  gem "github-pages", group: :jekyll_plugins

  group :jekyll_plugins do
    gem "jekyll-feed"
    gem "jekyll-sitemap"
    gem "hawkins"
  end

  gem "jekyll", "~> 3.9", group: :jekyll_plugins
  gem "wdm", "~> 0.1.0" if Gem.win_platform?
else
  # Offline-friendly stub Gemfile that satisfies Bundler without external network
  # access. The real GitHub Pages build continues to install the upstream gems
  # listed in the branch above when run in an unrestricted environment, but the
  # local development workflow can rely on vendored stand-ins that provide
  # minimal shims so that `bundle install` succeeds behind a proxy that blocks
  # rubygems.org.

  # The shim gems live under vendor/local_gems. Bundler treats `path` gems as
  # already satisfied and therefore never contacts rubygems.org.
  gem "jekyll", path: "vendor/local_gems/jekyll"

  group :jekyll_plugins do
    gem "github-pages", path: "vendor/local_gems/github-pages"
    gem "jekyll-feed", path: "vendor/local_gems/jekyll-feed"
    gem "jekyll-sitemap", path: "vendor/local_gems/jekyll-sitemap"
    gem "hawkins", path: "vendor/local_gems/hawkins"
  end

  # Windows only dependency kept for completeness (noop shim).
  gem "wdm", path: "vendor/local_gems/wdm"
end
