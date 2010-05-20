begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "s6-gen"
    s.executables = "new-s6-presentation"
    s.summary = "Create new S6 presenations using Haml"
    s.email = "john@coswellproductions.com"
    s.homepage = "http://github.com/johnbintz/s6-gen"
    s.description = "Create new S6 presenations using Haml"
    s.authors = ["JJohn Bintz"]
    s.files =  FileList["[A-Z]*", "{bin,generators,lib,test}/**/*"]
    s.add_dependency 'haml'
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
