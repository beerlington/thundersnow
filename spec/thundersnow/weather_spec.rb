require './spec/spec_helper'

describe 'Weather' do
  context 'with a bad response' do
    before do
      xml = File.read('./spec/support/bad_response.xml')
      FakeWeb.register_uri(:get, %r|http://www\.google\.com/|, :body => xml)
      @weather = Thundersnow::Weather.new('05408')
    end

    it 'should not be valid' do
      @weather.should_not be_valid
    end
  end

  context 'with a good response' do
    before do
      xml = File.read('./spec/support/ok_response.xml')
      FakeWeb.register_uri(:get, %r|http://www\.google\.com/|, :body => xml)
      @weather = Thundersnow::Weather.new('05408')
    end

    subject { @weather }
    it { should be_valid }
    its(:city) { should eql('Burlington, VT') }
    its(:condition) { should eql('Mostly Cloudy') }
    its(:temp_f) { should eql('68') }
    its(:temp_c) { should eql('20') }
    its(:wind) { should eql('Wind: NE at 3 mph') }
    its(:humidity) { should eql('Humidity: 87%') }
    its(:current) { should_not be_empty }
    its(:forecast) { should_not be_empty }
  end

end
