module Kanji::Neurons
  class Net
    attr_accessor :inputs, :weights

    def initialize(options)
      @weights = []
      @inputs = []
      @layers = [[], [], []]
      @input_total = options[:neurons]
    end

    def add_input(sample)
      @inputs << sample
    end

    def setup_neuron_layers
      @input_total.times do |t|
        # layer 0 is for inputs
        @layers[0][t] = 0
        @layers[1][t] = rand(2)
        @layers[2][0] = 1
      end

      setup_weights
    end

    # == Weights ==
    #
    # Any connection between two neurons has a weight value. Given
    # the following layers setup:
    #
    #   [[a, b, c], [d, e, f]]
    #
    #   (letters are neurons; abc are layer 0 or input, def are layer 1)
    #
    # The weights' structure will be like:
    #
    #   [layer_1][neuron_1_position][layer_2][neuron_2_position]
    #
    #   i.e [0][1][1][0] is the weight value between b and d
    def setup_weights
      @weights = Array.new(@layers.length) do
        Array.new(@layers[0].length) do
          Array.new(@layers.length) do
            Array.new(@layers[2].length) { nil }
          end
        end
      end

      @layers.each_with_index do |layers, layer|
        break if @layers[layer+1].nil?

        layers.each_with_index do |neuron, position|
          @layers[layer+1].each_with_index do |next_neuron, next_layer_position|

            @weights[layer][position][layer+1][next_layer_position] = 
              (rand(9).to_f + 1) / (rand(100).to_f + 9)
          end
        end
      end
    end

    def execute(input)
      raise "invalid input" if input.length != @inputs[0].length
      @layers[0] = input

      result = 0
      neuron_input = 0.0
      @layers.each_with_index do |layer, layer_index|
        next if layer_index == 0
        break if @layers[layer_index+1].nil?
        layer.each_with_index do |neuron, neuron_position|

          neuron_input = 0.0

          # gets the current result by going back
          # to the last layer and calculates the weights
          @layers[layer_index-1].each_with_index do |last_neuron, last_neuron_position|
            neuron_input += 
              last_neuron * @weights[layer_index-1][last_neuron_position][layer_index][neuron_position]
          end

          @layers[layer_index][neuron_position] = neuron_input
        end
      end

      neuron_input
    end

    def backpropagate(expected_output, output, learning_rate = 0.5)
      output_error = expected_output - output

      result = 0
      neuron_input = 0.0

      # starts from the output neuron
      layer_index = @layers.length
      @layers.reverse.each do |layer|
        layer_index -= 1
        next if layer_index == 0
        break if @layers[layer_index-1].nil?

        layer.each_with_index do |neuron, neuron_position|

          # gets the current result by going back
          # to the last layer and calculates the weights
          @layers[layer_index-1].each_with_index do |last_neuron, last_neuron_position|
            next if (layer_index-1) < 0

            # Change all weight values of each weight matrix using 
            # the formula weight(old) + learning rate * output error
            # * output(neurons i) * output(neurons i+1) * ( 1 - output(neurons i+1) )
            old_weight = @weights[layer_index-1][last_neuron_position][layer_index][neuron_position]
            old_neuron_output = last_neuron * old_weight

            new_weight = old_weight + learning_rate * output_error * output *
              old_neuron_output * (1-(old_neuron_output))

            # puts expected_output.to_s + " = " +old_weight.to_s + " -> " + new_weight.to_s
            @weights[layer_index-1][last_neuron_position][layer_index][neuron_position] = new_weight
          end
        end

      end
    end
  end
end
