# frozen_string_literal: true

module GitHub
  module Pages
    VERSION = "999.0.0"

    def self.inform_offline_mode
      warn "[github-pages] Offline shim active: upstream gems not installed."
    end
  end
end

GitHub::Pages.inform_offline_mode
