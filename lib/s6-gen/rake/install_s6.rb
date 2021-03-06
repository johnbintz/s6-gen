require 's6-gen'
require 'fileutils'

namespace :s6 do
  desc "Install S6 into the public directory of this presentation"
  task :install do
    FileUtils.mkdir_p 'public'
    FileUtils.cp_r File.join(S6Gen::ROOT, 's6'), 'public'
    FileUtils.cp_r File.join(S6Gen::ROOT, 'jquery'), 'public'
    FileUtils.rm_rf 'public/s6/.git'
  end
end
