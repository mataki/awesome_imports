require File.expand_path('spec_helper', File.dirname(__FILE__))

describe AwesomeImports::CsvImportsController do
  describe "#index" do
    before do
      @controller = create_controller
    end
    it "should success to call" do
      @controller.new
      @controller.instance_variable_get('@keyword_import').should be_is_a(KeywordImport)
    end
  end

  describe "#create" do
    before do
      @param = mock(:param)
      @controller = create_controller({ :keyword_import => @param })

      @import = mock(:import)
      KeywordImport.stub(:new).and_return(@import)
      @import.stub(:confirm)
      @import.stub(:store_attached_csv_file)
    end
    it "should success to call" do
      @controller.create
      @controller.instance_variable_get('@keyword_import').should == @import
    end
  end

  describe "#update" do
    before do
      @param = mock(:param)
      @controller = create_controller({ :keyword_import => @param })

      @import = mock(:import)
      @import.stub(:update).and_return(true)
      KeywordImport.stub(:restore_from_file).and_return(@import)
    end
    it "should success to call" do
      @controller.should_receive(:redirect_to).with({ :action => :new })
      @controller.update
    end
  end

  def create_controller(params={}, session = {})
    req = Struct.new(:parameters)
    request = req.new(params)
    controller = KeywordImportsController.new
    controller.request = request
    controller.stub(:session).and_return(session)
    controller.stub(:flash).and_return({})
    controller.stub(:redirect_to)
    controller
  end
end
