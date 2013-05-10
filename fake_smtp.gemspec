# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_smtp/version'

Gem::Specification.new do |gem|
  gem.name          = "fake_smtp"
  gem.version       = FakeSmtp::VERSION
  gem.authors       = ["Russ Olsen"]
  gem.email         = ["russ@russolsen.com"]
  gem.description   = %q{A minimal, do-nothing SMTP server}
  gem.summary       = %q{A fake SMTP server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
