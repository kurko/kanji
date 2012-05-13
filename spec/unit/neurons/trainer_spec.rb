require "spec_helper"

describe Kanji::Neurons::Base do
  before do
    @net = Kanji::Neurons::Base.new
    @net.create_net(:samurai)
    @net.create_net(:shinobi)
    @net.add_input(:samurai, [1,0,0,1,1])
    @net.add_input(:shinobi, [1,0,1,0,0])
  end

  describe "initialization" do
    it "" do
      @net.trainer.train
      @net.trainer.nets[:samurai].execute([1,0,0,1,1]).should > 0.9
      @net.trainer.nets[:shinobi].execute([1,0,1,0,0]).should > 0.9
      @net.trainer.nets[:shinobi].execute([1,0,0,1,1]).should < 0.1
      @net.trainer.nets[:samurai].execute([1,0,1,0,0]).should < 0.1
    end
  end

  describe "#expected_output" do
    it "should return 1 if input is correct" do
      @net.trainer.expected_output(:samurai, [1,0,0,1,1]).should > 0.9
    end

    it "should return 0 if input is incorrect" do
      @net.trainer.expected_output(:shinobi, [1,0,1,0,0]).should > 0.9
    end
  end
end
