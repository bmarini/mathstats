class Mathstats
  class << self
    # Calculates the mean (or average) from a set of values
    #
    # Normal usage:
    #   Mathstats.mean([1,2,3,4,5]) # => 3.0
    #
    # With a default value when set is empty:
    #   Mathstats.mean([], 0) # => 0.0
    #
    # With a block to modify values:
    #   Mathstats.mean([1,2,3,4,5]) { |v| v - 1 } # => 2.5
    def mean(values, identity = 0, &block)
      values.size > 0 ? sum(values, identity, &block) / values.size.to_f : identity
    end
    alias_method :average, :mean

    # Calculates the standard deviation from a set of values
    def standard_deviation(values, options = {}, &block)
      options = {:default => 0}.merge(options)
      return options[:default] unless values.size > 0

      if block_given?
        return standard_deviation( values.map(&block), options )
      end

      Math.sqrt( variance(values, options) )
    end

    # Calculates the sum from a set of values
    def sum(values, identity = 0, &block)
      return identity unless values.size > 0

      if block_given?
        sum( values.map(&block) )
      else
        values.inject { |sum, element| sum + element }
      end
    end

    # Two pass algorithm is currently the only algo supported
    # http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
    def variance(values, options = {}, &block)
      options = {:default => 0, :algo => :two_pass, :population => :infinite}.merge(options)
      return options[:default] unless values.size > 0

      if block_given?
        return variance( values.map(&block), options )
      end

      variance_two_pass(values, options)
    end

    def variance_two_pass(values, options)
      n        = values.size
      denom    = options[:population] == :infinite ? n - 1 : n
      mean     = mean(values)
      variance = values.inject(0) {|memo, element| memo + (element - mean)**2 } / denom
    end

    # Convenience method for including Mathstats as a mixin.
    #   Mathstats.attach_to(Array)
    def attach_to(klass)
      klass.send :include, Mixin
    end
  end

  # All the class methods from Mathstats above are available in the Mixin
  # module, via delegation. This module can be included in any class that
  # has a method `#to_a` like Array

  module Mixin
    def self.delegate_to_mathstats(*symbols)
      Array(symbols).each do |symbol|
        class_eval <<-EOS, __FILE__, __LINE__ + 1
          def #{symbol}(*args, &block)
            Mathstats.#{symbol}(self.to_a, *args, &block)
          end
        EOS
      end
    end

    delegate_to_mathstats :mean, :average, :standard_deviation, :sum, :variance
  end
end
