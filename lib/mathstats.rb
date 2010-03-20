class Mathstats
  class << self
    def mean(array, identity = 0, &block)
      array.size > 0 ? sum(array, identity, &block) / array.size.to_f : identity
    end
    alias_method :average, :mean

    def standard_deviation(array, options = {}, &block)
      options = {:default => 0}.merge(options)
      return options[:default] unless array.size > 0

      if block_given?
        return standard_deviation( array.map(&block), options )
      end

      Math.sqrt( variance(array, options) )
    end

    def sum(array, identity = 0, &block)
      return identity unless array.size > 0

      if block_given?
        sum( array.map(&block) )
      else
        array.inject { |sum, element| sum + element }
      end
    end

    # Two pass algorithm is currently the only algo supported
    # http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
    def variance(array, options = {}, &block)
      options = {:default => 0, :algo => :two_pass, :population => :infinite}.merge(options)
      return options[:default] unless array.size > 0

      if block_given?
        return variance( array.map(&block), options )
      end

      variance_two_pass(array, options)
    end

    def variance_two_pass(array, options)
      n        = array.size
      denom    = options[:population] == :infinite ? n - 1 : n
      mean     = mean(array)
      variance = array.inject(0) {|memo, element| memo + (element - mean)**2 } / denom
    end

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
