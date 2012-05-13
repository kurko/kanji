module Kanji::Neurons
  class Trainer
    attr_accessor :nets, :samples

    def initialize(nets)
      @nets = nets
      @samples = {}
    end

    def add_sample(net_name, sample)
      @nets[net_name].add_input(sample)
      @samples[net_name] = [] unless @samples.has_key?(net_name)
      @samples[net_name] << sample
    end

    def train
      5000.times do
        net_name = random_sample.keys.first
        net = @nets[net_name]
        sample = random_sample

        output = net.execute(sample.values.first)
        expected = expected_output(net_name, sample.values.first)
        #print expected
        #print " = "
        #puts output

        net.backpropagate(expected, output)
      end
    end


    def expected_output(net_name, input)
      @nets[net_name].inputs.any? { |i| i == input } ? 1 : 0
    end

    private

    def random_sample
      random_net = @samples.keys[rand(@samples.keys.length)]
      random_samples = @samples[random_net]
      random_sample = random_samples[rand(random_samples.length)]
      {random_net => random_sample}
    end
  end
end
