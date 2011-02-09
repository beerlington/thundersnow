require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Thundersnow do
  before do
    Thundersnow.stub(:open).and_return(XML)
    Thundersnow.stub(:show).and_return(true)
  end

  context "for current conditions" do
    before do
      @args = [ZIP]
    end

    context "when running" do

      it "should set the @xml instance variable" do
        Thundersnow.run @args
        Thundersnow.instance_variable_get('@xml').to_s.should == Nokogiri::XML(XML).to_s
      end

      it "should show the current conditions" do
        Thundersnow.should_receive(:show).with(:current).once
        Thundersnow.run @args
      end

      it "should not show the forecast conditions" do
        Thundersnow.should_not_receive(:show).with(:forecast)
        Thundersnow.run @args
      end
    end
  end

  context "for forecast conditions" do
    before do
      @args = [ZIP, '--forecast']
    end

    context "when running" do

      it "should set the @xml instance variable" do
        Thundersnow.run @args
        Thundersnow.instance_variable_get('@xml').to_s.should == Nokogiri::XML(XML).to_s
      end

      it "should show the forecast conditions" do
        Thundersnow.should_receive(:show).with(:forecast).once
        Thundersnow.run @args
      end

      it "should not show the current conditions" do
        Thundersnow.should_not_receive(:show).with(:current)
        Thundersnow.run @args
      end
    end
  end

  context "w/ invalid location" do
    before do
      Thundersnow.stub(:open).and_return(BAD_XML)
    end

    context "when running" do
      before do
        Thundersnow.stub(:show).and_return(true)
        @args = [ZIP]
      end

      it "should set the @xml instance variable" do
        Thundersnow.run @args
        Thundersnow.instance_variable_get('@xml').to_s.should == Nokogiri::XML(BAD_XML).to_s
      end

      it "should return and not show anything" do
        Thundersnow.should_not_receive(:show)
        Thundersnow.run @args
      end
    end
  end

end
