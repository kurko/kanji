require "kanji/neurons/net"
require "kanji/neurons/trainer"

module Kanji::Neurons
  class Base

    def initialize(image_path = nil)
      @nets = {}
      @weights = {}
      @samples = {}
      @trainer = nil
    end

    def create_net(net_name)
      @nets[net_name] = Net.new(neurons: 5)
      @nets[net_name].setup_neuron_layers
    end

    def add_input(net_name, sample)
      trainer.add_sample(net_name, sample)
    end

    def trainer
      @trainer ||= Trainer.new(@nets)
    end

    def train
      trainer.train
    end

    private

    def output_log
      puts "neurons: "+@nets.inspect
      puts "weigths: "+@weights.inspect
      
      puts ""
    end

  end


end

