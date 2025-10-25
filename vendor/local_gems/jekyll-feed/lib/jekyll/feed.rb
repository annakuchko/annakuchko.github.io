# frozen_string_literal: true

module Jekyll
  module Feed
    VERSION = "0.999.0"

    def self.generate(_site = nil)
      warn "[jekyll-feed] Offline shim active. Skipping feed generation."
    end
  end
end
