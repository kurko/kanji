# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kanji/version"

Gem::Specification.new do |s|
  s.name        = "kanji"
  s.version     = Kanji::VERSION
  s.authors     = ["Alexandre de Oliveira"]
  s.email       = ["chavedomundo@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Recognize japanese Kanjis in images}
  s.description = %q{Attempt to create a gem based on machine learning for recognize japanese Kanjis in images.}

  s.rubyforge_project = "kanji"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "oily_png"
  s.add_runtime_dependency "ruby-fann"
end
