Gem::Specification.new do |spec|
  spec.name          = "jekyll"
  spec.version       = "3.9.0"
  spec.summary       = "Offline shim for the Jekyll CLI used in restricted environments."
  spec.description   = "Provides a minimal implementation of the commands used by this repo so Bundler can install without contacting rubygems.org."
  spec.authors       = ["Academic Pages Maintainers"]
  spec.email         = ["maintainers@example.com"]
  spec.files         = Dir.glob("lib/**/*.rb") + Dir.glob("exe/*")
  spec.bindir        = "exe"
  spec.executables   = Dir["exe/*"].map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.homepage      = "https://github.com/academicpages/academicpages.github.io"
  spec.license       = "MIT"
end
