require "spec_helper"

describe "Execution" do
  let(:samurai_sample) { "./spec/fixtures/images/samurai_kanji.png" }
  let(:shinobi_sample) { "./spec/fixtures/images/shinobi_kanji.png" }

  describe "image training" do
    before do
      @samurai = Kanji::Image::Base.new(samurai_sample).get_pixels(0.01).prepare_for_neurons
      @shinobi = Kanji::Image::Base.new(shinobi_sample).get_pixels(0.01).prepare_for_neurons
    end

    it "trains two kanjis" do
      neural_net = Kanji::Neurons::Base.new

      neural_net.create_net(:samurai, @samurai.length)
      neural_net.create_net(:shinobi, @shinobi.length)
      neural_net.add_input(:samurai, @samurai)
      neural_net.add_input(:shinobi, @shinobi)

      neural_net.train
      neural_net.trainer.nets[:samurai].execute(@samurai).should > 0.8
      neural_net.trainer.nets[:shinobi].execute(@shinobi).should > 0.8
      neural_net.trainer.nets[:samurai].execute(@shinobi).should < 0.3
      neural_net.trainer.nets[:shinobi].execute(@samurai).should < 0.3
    end
  end
end
