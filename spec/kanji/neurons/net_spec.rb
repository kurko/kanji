require "spec_helper"

describe Kanji::Neurons::Net do
  before do
    @net = Kanji::Neurons::Net.new(neurons: 3)
  end

  specify "#add_input" do
    @net.add_input([1,0,1])
    @net.add_input([0,1,0])
    @net.inputs.should include [1,0,1]
  end

  describe "initialization" do
    specify "#setup_neuron_layers" do
      @net.should_receive(:setup_weights)
      @net.setup_neuron_layers
    end

    specify "#setup_weights" do
      @net = Kanji::Neurons::Net.new(neurons: 1)
      @net.setup_neuron_layers
      @net.setup_weights

      @net.weights[0][0][0][0].should be_nil
      @net.weights[0][0][1][0].should > 0
      @net.weights[0][0][2][0].should be_nil
      @net.weights[1][0][0][0].should be_nil
      @net.weights[1][0][1][0].should be_nil
      @net.weights[1][0][2][0].should > 0
    end
  end

  describe "execution" do
    it "should execute" do
      @net.setup_neuron_layers
      @net.execute([0,1,0]).should > 0
      @net.execute([0,1,0]).should < 1
    end
  end
end
