require "awesome_imports/version"
require 'active_support'

module AwesomeImports
  extend ActiveSupport::Autoload

  autoload :CsvImport
  autoload :CsvImportsController
end
