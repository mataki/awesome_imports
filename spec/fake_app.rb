class KeywordImport < AwesomeImports::CsvImport
end

class KeywordImportsController < ActionController::Base
  include AwesomeImports::CsvImportsController
end
