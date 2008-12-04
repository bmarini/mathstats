module Mathstats
  def average(identity = 0, &block)
    Lib.average(self, identity, &block)
  end
  
  def sum(identity = 0, &block)
    Lib.sum(self, identity, &block)
  end
  
  class Lib
    def self.average(array, identity = 0, &block)
      array.size > 0 ? sum(array, identity, &block) / array.size.to_f : identity
    end

    def self.sum(array, identity = 0, &block)
      return identity unless array.size > 0

      if block_given?
        sum( array.map(&block) )
      else
        array.inject { |sum, element| sum + element }
      end
    end
   
  end
end