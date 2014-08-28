module Kanji::Neurons
  class Base
    attr_accessor :nets

    def initialize(image_path = nil)
      @nets = {}
      @samples = {}
      @train_data = {}
    end

    def create_net(net_name, neurons_length)
      fann = ::RubyFann::Standard.new(
        num_inputs: neurons_length,
        hidden_neurons: [neurons_length, neurons_length/2],
        num_outputs: 1
      )

      @nets[net_name] = fann
    end

    def add_input(net_name, sample)
      @samples[net_name] = sample
    end

    def train
      new_samples = {}
      @samples.each do |net, value|

        new_samples[net] = [value]
        @samples.each do |index, wrong_samples|
          next if net == index

          new_samples[net] << wrong_samples
        end

        desired_outputs = new_samples[net].each_with_index.map do |value, index|
          index == 0 ? [1] : [0]
        end

        @train_data[net] = RubyFann::TrainData.new(
          inputs: new_samples[net],
          desired_outputs: desired_outputs
        )

        @nets[net].train_on_data(@train_data[net], 10000, 0, 0.05)
      end
    end

    def what_is(input)
      current_guess = { answer: nil, certainty: 0.0 }
      @nets.each do |index, net|
        output = net.run(input).first
        if current_guess[:certainty] < output
          current_guess = { answer: index, certainty: output }
        end
      end
      current_guess
    end
  end
end
