require File.expand_path('spec_helper', File.dirname(__FILE__))

describe AwesomeImports::CsvImport do
  before do
    @import = KeywordImport.new
  end
  describe "#persisted?" do
    it "should success to call" do
      @import.persisted?.should be_false
    end
  end

  describe "#id" do
    it "should success to call" do
      @import.id.should be_nil
    end
  end

  describe "#initialize" do
    before do
      @mock_csv = mock(:csv)
      @import = KeywordImport.new(:csv_file => @mock_csv)
    end
    it "should success to call" do
      @import.csv_file.should == @mock_csv
    end
  end

  describe "#confirm" do
  end

  describe "#parse_csv_from_uploaded_file" do
  end

  describe "#parse_csv" do
  end

  describe "#records" do
    it "should success to call" do
      @import.records.should be_is_a(Array)
    end
  end

  describe "#store_attached_csv_file" do
  end

  describe "#csv_tmp_dir" do
  end

  describe ".restore_from_file" do
  end

  describe "#load_stored_csv" do
  end

  describe "#parse_csv_from_stored_file" do
  end

  describe "#update" do
  end
end
