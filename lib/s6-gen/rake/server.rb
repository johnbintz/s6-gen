namespace :server do
  desc "Start Thin"
  task :thin do
    system %{thin start}
  end
end
