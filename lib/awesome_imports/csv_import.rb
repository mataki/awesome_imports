require "csv"
require "active_model"
require "active_record"
require "active_record/validations"
require "active_support/core_ext"

module AwesomeImports
  class CsvImport
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::AttributeMethods

    def persisted?
      csv_file.present? or stored_csv_path.present?
    end

    def id
    end

    define_attribute_methods ["csv_file", "user"]
    attr_accessor :csv_file, :user

    def initialize(attr = {})
      attribute = attr.with_indifferent_access
      self.csv_file = attribute[:csv_file]
    end

    def confirm
      @records = parse_csv_from_uploaded_file
      records.each{ |record| record.valid? }
      records
    end

    def parse_csv_from_uploaded_file
      parse_csv(csv_file.tempfile)
    end

    def parse_csv(file_path)
      rows = []
      CSV.foreach(file_path, :encoding => "utf-8") do |row|
        if respond_to?(:parse_row)
          rows << parse_row(row)
        else
          rows << row
        end
      end
      rows
    end

    def records
      @records || []
    end

    def store_attached_csv_file
      FileUtils.cp(csv_file.tempfile.path, csv_tmp_dir)
      File.join(csv_tmp_dir, File.basename(csv_file.tempfile.path))
    end

    def csv_tmp_dir
      dir = File.join(Rails.root, "tmp", "csv_import")
      FileUtils.mkdir_p(dir)
      dir
    end

    def self.restore_from_file(file_path)
      res = new
      res.load_stored_csv(file_path)
      res
    end

    def load_stored_csv(file_path)
      @stored_csv_path = file_path
    end
    attr_reader :stored_csv_path

    def parse_csv_from_stored_file
      parse_csv(stored_csv_path)
    end

    def update
      @records = parse_csv_from_stored_file
      ActiveRecord::Base.transaction do
        records.each do |record|
          record.save!
        end
      end
      FileUtils.rm(stored_csv_path)
      remove_old_stored_csvs
      true
    rescue ActiveRecord::RecordInvalid => e
      records.each{ |record| record.valid? }
      false
    end

    private
    # TODO: Remove old csv files
    def remove_old_stored_csvs
    end

  end
end
