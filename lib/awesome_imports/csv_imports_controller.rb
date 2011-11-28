# -*- coding: utf-8 -*-
module AwesomeImports
  module CsvImportsController
    extend ActiveSupport::Concern

    module InstanceMethods

      def new
        instance_variable_set("@#{import_name}", resource_class.new)
      end

      def create
        import = resource_class.new(params[import_name.to_sym])
        import.user = current_user if respond_to?(:current_user)
        import.confirm
        session[import_name.to_sym] = import.store_attached_csv_file

        instance_variable_set("@#{import_name}", import)
      end

      def update
        import = resource_class.restore_from_file(session[import_name.to_sym])
        import.user = current_user if respond_to?(:current_user)
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

      private
      def object_name
        self.class.object_name
      end

      def import_name
        self.class.import_name
      end

      def resource_class
        self.class.resource_class
      end
    end

    module ClassMethods
      def object_name
        self.name.underscore.split('_').first # "keyword"
      end

      def import_name
        [object_name, "import"].join('_')     # "keyword_import"
      end

      def resource_class
        import_name.classify.constantize   # KeywordImport
      end
    end
  end
end
