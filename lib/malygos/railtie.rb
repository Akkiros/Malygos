require 'malygos'
require 'rails'

module Malygos
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/malygos.rake"
    end 
  end
end
