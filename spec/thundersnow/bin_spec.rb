require './spec/spec_helper'

describe 'Bin' do

  context 'valid response' do
    before do
      weather = mock(:weather, :valid? => true)
      Thundersnow::Weather.stub(:new).and_return(weather)
    end

    context 'w/out --forecast option' do
      before do
        args = ['05408']
        @thundersnow = Thundersnow::Bin.new(args)
      end

      it 'should show the current conditions' do
        @thundersnow.should_receive(:show).with(:current)
        @thundersnow.run
      end
    end

    context 'with --forecast' do
      before do
        args = ['05408', '--forecast']
        @thundersnow = Thundersnow::Bin.new(args)
      end

      it 'should show the forecast conditions' do
        @thundersnow.should_receive(:show).with(:forecast)
        @thundersnow.run
      end
    end
  end

  context 'invalid response' do
    before do
      weather = mock(:weather, :valid? => false)
      Thundersnow::Weather.stub(:new).and_return(weather)
      args = ['05408']
      @thundersnow = Thundersnow::Bin.new(args)
    end

    it 'should return without displaying the weather' do
      @thundersnow.should_not_receive(:show)
      @thundersnow.run
    end
  end
end
