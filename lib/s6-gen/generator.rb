require 'haml'
require 'compass'
require 'sass'
require 'fileutils'

module S6Gen
  module Generator
    def all!
      html!
      css!
    end

    def html!
      raise "No #{@source_dir}/index.haml file found!" if !File.exist?("#{@source_dir}/index.haml")

      FileUtils.mkdir_p @target_dir

      layout = File.exist?("#{@source_dir}/layout.haml") ? "#{@source_dir}/layout.haml" : File.join(S6Gen::ROOT, 'templates/layout.haml')
      File.open("#{@target_dir}/index.html", 'w') do |file|
        file.puts Haml::Engine.new(File.read(layout)).to_html(self) { render('index.haml') }
      end
    end

    def css!
      raise "No #{@source_dir}/style.sass file found!" if !File.exist?("#{@source_dir}/style.sass")

      FileUtils.mkdir_p @target_dir

      Compass.configuration do |config|
        config.project_path = Dir.pwd
        config.sass_dir = @source_dir

        config.images_dir = File.join(@target_dir, 'graphics')
        config.http_path = ""
        config.http_images_path = 'graphics'
        config.output_style = :compact
      end

      File.open("#{@target_dir}/style.css", 'w') do |file|
        file.puts Sass::Engine.new(File.read("#{@source_dir}/style.sass"), Compass.sass_engine_options).to_css
      end
    end

    def render(file)
      Haml::Engine.new(File.read(File.join(@source_dir, file))).to_html(self)
    end
  end
end
