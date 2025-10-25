# frozen_string_literal: true

module Jekyll
  module Sitemap
    VERSION = "1.999.0"

    def self.generate(_site = nil)
      warn "[jekyll-sitemap] Offline shim active. Skipping sitemap generation."
    end
  end
end
