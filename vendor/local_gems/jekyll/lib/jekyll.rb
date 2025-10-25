# frozen_string_literal: true

require "yaml"
require "fileutils"

module Jekyll
  VERSION = "3.9.0"

  module Offline
    module_function

    def ensure_site_directory(path)
      FileUtils.mkdir_p(path)
    end

    def copy_static_assets(source_dir, destination_dir)
      return unless Dir.exist?(source_dir)

      Dir.glob(File.join(source_dir, "**", "*"), File::FNM_DOTMATCH).each do |item|
        next if File.directory?(item)
        next if File.basename(item).start_with?(".")

        relative = item.delete_prefix(File.join(source_dir, "/"))
        target = File.join(destination_dir, relative)
        FileUtils.mkdir_p(File.dirname(target))
        FileUtils.cp(item, target)
      end
    end

    def generate_placeholder_site(destination_dir)
      ensure_site_directory(destination_dir)
      index = File.join(destination_dir, "index.html")
      return if File.exist?(index)

      File.write(index, <<~HTML)
        <!doctype html>
        <html lang="en">
          <head>
            <meta charset="utf-8">
            <title>Offline Jekyll Stub</title>
            <style>
              body { font-family: system-ui, sans-serif; margin: 3rem auto; max-width: 40rem; line-height: 1.6; }
              code { background: #f5f5f5; padding: 0.2rem 0.4rem; border-radius: 0.3rem; }
            </style>
          </head>
          <body>
            <h1>Offline Jekyll Stub</h1>
            <p>
              This environment cannot reach rubygems.org, so the real Jekyll build
              is unavailable. The shim bundle leaves this placeholder page in
              <code>_site</code> so local previews keep working.
            </p>
            <p>
              When you regain network access run <code>bundle update</code> to
              restore the official gems.
            </p>
          </body>
        </html>
      HTML
    end

    def build(destination_dir)
      ensure_site_directory(destination_dir)
      copy_static_assets("_site_seed", destination_dir)
      generate_placeholder_site(destination_dir)
    end

    def mime_type_for(path)
      case File.extname(path).downcase
      when ".html", ".htm"
        "text/html; charset=utf-8"
      when ".css"
        "text/css; charset=utf-8"
      when ".js"
        "application/javascript; charset=utf-8"
      when ".png"
        "image/png"
      when ".jpg", ".jpeg"
        "image/jpeg"
      when ".svg"
        "image/svg+xml"
      when ".json"
        "application/json; charset=utf-8"
      else
        "application/octet-stream"
      end
    end
  end
end
