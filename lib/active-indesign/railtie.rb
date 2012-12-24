require 'active-indesign'
require 'rails'

module MyGem
  class Railtie < Rails::Railtie
    
    def self.root
        Pathname.new("#{File.dirname(__FILE__)}")
      end
      
  	rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end
end
