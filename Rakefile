begin
  require 'rubygems'
  require 'bundler'
  Bundler.setup
rescue => e
  warn "FATAL - #{e}"
  exit 1
end

gemspec = eval(File.read(Dir['*.gemspec'].first))
file    = [gemspec.name, gemspec.version].join('-') + '.gem'

task :validate do
  gemspec.validate
end

task :build do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir_p 'gems'
  FileUtils.mv file, 'gems'
end

task :install => [:validate, :build] do
  system "sudo -E sh -c \'umask 022; gem install gems/#{file} --no-ri --no-rdoc\'"
  FileUtils.rm_rf 'gems'
end

task :remove do
  system "sudo -E sh -c \'umask 022; gem uninstall #{gemspec.name}\'"
end
