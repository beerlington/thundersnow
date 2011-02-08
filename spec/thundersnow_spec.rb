require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Thundersnow" do
  before do
    Thundersnow.stub(:open).and_return(XML)
  end

  context "when running" do
    before do
      Thundersnow.stub(:show).and_return(true)
    end

    it "should set the @xml instance variable" do
      Thundersnow.run ZIP
      Thundersnow.instance_variable_get('@xml').to_s.should == Nokogiri::XML(XML).to_s
    end

    [:city, :condition, :temperatures, :wind, :humidity, :forecast].each do |node|
      it "should show the #{node}" do
        Thundersnow.should_receive(:show).with(node).once
        Thundersnow.run ZIP
      end
    end
  end
end
