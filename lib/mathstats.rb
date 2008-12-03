module Mathstats
  def average(identity = 0, &block)
    Lib.average(self, identity, &block)
  end
  
  class Lib
    def self.average(array, identity = 0, &block)
      return identity unless array.size > 0


      if block_given?
        average array.map(&block)
      else
        array.inject { |sum, element| sum + element } / array.size.to_f
      end
    end
  end
end