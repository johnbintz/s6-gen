require 's6-gen'
require 's6-gen/presentation'
require 'fileutils'
require 'sass'

module S6Gen
  module RakeHelper
    def all!
      html!
      css!
    end

    def html!
      raise "No src/index.haml file found!" if !File.exist?('src/index.haml')

      FileUtils.mkdir_p 'public'

      layout = File.exist?('src/layout.haml') ? 'src/layout.haml' : File.join(S6Gen::ROOT, 'templates/layout.haml')
      File.open('public/index.html', 'w') do |file|
        file.puts Haml::Engine.new(File.read(layout)).to_html(self) { S6Gen::Presentation.render('index.haml', 'src') }
      end
    end

    def css!
      raise "No src/style.sass file found!" if !File.exist?('src/style.sass')

      FileUtils.mkdir_p 'public'

      File.open('public/style.css', 'w') do |file|
        file.puts Sass::Engine.new(File.read('src/style.sass')).to_css
      end
    end
  end
end

include S6Gen::RakeHelper

namespace :s6 do
  desc "Regenerate presentation index.html file"
  task :regenerate_html do
    html!
  end

  desc "Regenerate style.css"
  task :regenerate_css do
    css!
  end

  desc "Regenerate everything"
  task :regenerate => [ :regenerate_html, :regenerate_css ]

  desc "Watch for changes and regenerate when needed"
  task :watch do
    require 'directory_watcher'

    watcher = DirectoryWatcher.new 'src', :pre_load => true
    watcher.interval = 1
    watcher.add_observer do |*args|
      args.each { |e| puts e }

      all!
    end

    puts ">> S6-Gen is watching for changes, press Enter to quit"
    watcher.start
    $stdin.gets
    puts ">> Shutting down"
    watcher.stop
  end
end
