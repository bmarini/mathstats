module Mathstats
  def mean(identity = 0, &block)
    Lib.average(self, identity, &block)
  end
  alias_method :average, :mean
  
  def sum(identity = 0, &block)
    Lib.sum(self, identity, &block)
  end
  
  def variance(options = {}, &block)
    Lib.variance(self, options, &block)
  end
  
  class Lib
    
    def self.mean(array, identity = 0, &block)
      array.size > 0 ? sum(array, identity, &block) / array.size.to_f : identity
    end
    
    # Poor man's alias_method until I figure out how to do this right
    def self.average(array, identity = 0, &block); mean(array, identity, &block); end
    
    def self.sum(array, identity = 0, &block)
      return identity unless array.size > 0

      if block_given?
        sum( array.map(&block) )
      else
        array.inject { |sum, element| sum + element }
      end
    end

    # Two pass algorithm is currently the only algo supported
    # http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
    def self.variance(array, options = {}, &block)
      options = {:default => 0, :algo => :two_pass, :population => :infinite}.merge(options)
      return options[:default] unless array.size > 0
      
      if block_given?
        return variance( array.map(&block), options )
      end
      
      variance_two_pass(array, options)
    end
    
    def self.variance_two_pass(array, options)
      n        = array.size
      denom    = options[:population] == :infinite ? n -1 : n
      sum1     = sum(array)
      mean     = mean(array)
      sum2     = array.inject(0) {|memo, element| memo + (element - mean)**2 }
      variance = sum2 / denom
    end

  end
end