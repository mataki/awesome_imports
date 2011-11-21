# -*- coding: utf-8 -*-
module AwesomeImports
  module CsvImportsController
    extend ActiveSupport::Concern

    included do
      cattr_reader :object_name, :import_name, :resource_class

      @@object_name = self.name.underscore.split('_').first # "keyword"
      @@import_name = [object_name, "import"].join('_')     # "keyword_import"
      @@resource_class = import_name.classify.constantize   # KeywordImport
    end

    module InstanceMethods

      def new
        instance_variable_set("@#{import_name}", resource_class.new)
      end

      def create
        import = resource_class.new(params[import_name.to_sym])
        import.confirm
        session[import_name.to_sym] = import.store_attached_csv_file

        instance_variable_set("@#{import_name}", import)
      end

      def update
        import = resource_class.restore_from_file(session[import_name.to_sym])
        if import.update
          flash[:notice] = I18n.t("awesome_imports.controller.success")
          session[import_name.to_sym] = nil
          redirect_to :action => :new
        else
          flash.now[:notice] = I18n.t("awesome_imports.controller.failed")
          instance_variable_set("@#{import_name}", import)
          render :create
        end
      end
    end

    module ClassMethods
    end

  end
end
