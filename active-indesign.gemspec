# -*- encoding: utf-8 -*-
require File.expand_path('../lib/active-indesign/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Verschoor"]
  gem.email         = ["paul.verschoor@gmail.com"]
  gem.description   = %q{Creating Adobe Indesign templates and iterator scripts for ActiveRecord models. Rake task for creating a
                        .erb script file, which will includes all attributes from your Model, modify this erb scripts to your needs (and remove unneccesarry fields). Create with a rake task a template indesign script that will add all fields to your current active Document in Indesign
                        create a  created by Paul Verschoor
                        Adobe® Indesign®  
                        }
  gem.summary       = %q{rake tasks creating Adobe® Indesign® templates and iterator scripts for ActiveRecord models.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "active-indesign"
  gem.require_paths = ["lib"]
  gem.version       = ActiveIndesign::VERSION
end
