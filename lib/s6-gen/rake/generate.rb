require 'fileutils'

include S6Gen::Generator

@source_dir ||= 'src'
@target_dir ||= 'public'

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

    watcher = DirectoryWatcher.new @source_dir, :pre_load => true
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
