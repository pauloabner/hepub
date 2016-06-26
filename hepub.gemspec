# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'hepub'
  spec.version       = '0.0.1'
  spec.authors       = ['Paulo Abner Aurelio Mesquita']
  spec.email         = ['pauloabner@gmail.com']

  spec.summary       = %q{ A summary. }
  spec.description   = %q{ A description. }
  spec.homepage      = 'https://github.com/pauloabner'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|template)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gepub', '0.6.9.2'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'byebug', '9.0.5'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-core', '3.0.4'
  spec.add_development_dependency 'factory_girl', '4.7.0'
end
