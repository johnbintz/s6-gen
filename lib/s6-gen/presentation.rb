require 'haml'

module S6Gen
  class Presentation
    def self.render(file, root)
      presentation = self.new(root)
      presentation.render(file)
    end

    def initialize(root)
      @root = root
    end

    def render(file)
      Haml::Engine.new(File.read(File.join(@root, file))).to_html(self)
    end
  end
end
