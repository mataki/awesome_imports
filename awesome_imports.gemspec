# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "awesome_imports/version"

Gem::Specification.new do |s|
  s.name        = "awesome_imports"
  s.version     = AwesomeImports::VERSION
  s.authors     = ["Akihiro Matsumura"]
  s.email       = ["matsumura.aki@gmail.com"]
  s.homepage    = "https://github.com/mataki/awesome_imports"
  s.summary     = %q{Awesome csv importer for rails}
  s.description = %q{Cool and simple data importer for rails by CSV}

  s.rubyforge_project = "awesome_imports"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', ['>= 3.0.0']
  s.add_dependency 'activemodel', ['>= 3.0.0']
  s.add_dependency 'actionpack', ['>= 3.0.0']
  s.add_development_dependency 'rake', [">= 0"]
  s.add_development_dependency 'rspec', ['>= 0']
end
