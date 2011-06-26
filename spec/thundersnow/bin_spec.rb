require './spec/spec_helper'

describe 'Bin' do

  context 'valid response' do
    before do
      weather = mock(:weather, :valid? => true)
      Thundersnow::Weather.stub(:new).and_return(weather)
    end

    context 'w/out --forecast option' do
      before do
        @args = ['05408']
      end

      it 'should show the current conditions' do
        Thundersnow::Bin.should_receive(:show).with(:current)
        Thundersnow::Bin.run @args
      end
    end

    context 'with --forecast' do
      before do
        @args = ['05408', '--forecast']
      end

      it 'should show the forecast conditions' do
        Thundersnow::Bin.should_receive(:show).with(:forecast)
        Thundersnow::Bin.run @args
      end
    end
  end

  context 'invalid response' do
    before do
      weather = mock(:weather, :valid? => false)
      Thundersnow::Weather.stub(:new).and_return(weather)
    end

    it 'should return without displaying the weather' do
      Thundersnow::Bin.should_not_receive(:show)
      Thundersnow::Bin.run ['05408']
    end
  end
end
