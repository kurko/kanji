require "spec_helper"

describe Kanji::Neurons::Base do
  describe "#create_net" do
    before do
      @neurons = Kanji::Neurons::Base.new
      @net = double()
      @net.stub(:setup_neuron_layers)
    end

    it "should instantiate a new Net" do
      Kanji::Neurons::Net.should_receive(:new).and_return(@net)
      @neurons.create_net(:samurai)
    end
  end
end
