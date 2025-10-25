# frozen_string_literal: true

module Hawkins
  VERSION = "0.999.0"

  def self.activate!
    warn "[hawkins] Offline shim active."
  end
end

Hawkins.activate!
