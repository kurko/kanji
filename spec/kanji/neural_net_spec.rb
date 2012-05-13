require "spec_helper"

describe Kanji::Neurons::Base do
  let(:samurai_sample) { "./spec/fixtures/images/samurai_kanji_quality_10.png" }
  let(:shinobi_sample) { "./spec/fixtures/images/shinobi_kanji_quality_10.png" }

  describe "acceptance" do
    before do
      @samurai = Kanji::Image::Base.new(samurai_sample).prepare_for_neurons
      @shinobi = Kanji::Image::Base.new(shinobi_sample).prepare_for_neurons
    end

    it "trains two images" do
      neural_net = Kanji::Neurons::Base.new()

      neural_net.create_net(:samurai)
      neural_net.create_net(:shinobi)
      neural_net.create_net(:geisha)
      neural_net.add_input(:samurai, [1,0,0])
      neural_net.add_input(:shinobi, [1,1,0])
      neural_net.add_input(:geisha, [0,1,1])

      neural_net.train

      #neural_net.get_result(@samurai).should == "samurai"
    end
  end

  specify "#create_net" do
    neurons = Kanji::Neurons::Base.new
    Kanji::Neurons::Net.should_receive(:new)
    neurons.create_net(:samurai)
  end
end
