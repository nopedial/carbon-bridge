Gem::Specification.new do |s|
  s.name              = 'carbon-bridge'
  s.version           = '0.0.4'
  s.platform          = Gem::Platform::RUBY
  s.authors           = [ 'Samer Abdel-Hafez' ]
  s.email             = %w( sam@arahant.net )
  s.homepage          = 'http://github.com/nopedial/carbon-bridge'
  s.summary           = 'carbon-bridge'
  s.description       = 'carbon bridge'
  s.rubyforge_project = s.name
  s.files             = `git ls-files`.split("\n")
  s.executables       = %w( carbon-bridge )
  s.require_path      = 'lib'

  s.add_dependency 'asetus', '~> 0.3', '>= 0.3.0'
  s.add_dependency 'logger', '~> 1.2', '>= 1.2.8'
end
