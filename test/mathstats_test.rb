require 'test/unit'
require 'mathstats'

class TC_MyTest < Test::Unit::TestCase
  # def setup
  # end

  def test_as_module
    Array.send :include, Mathstats
    assert_equal 3, [1,2,3,4,5].average
    assert_equal(6, [1,2,3,4,5].average {|n| n * 2 })
    assert_equal(0, [].average(0))
    assert_equal('empty', [].average('empty'))
    
    assert_equal(1.5, [1,2].average)
  end
  
  def test_as_class
    assert_equal 3, Mathstats::Lib.average([1,2,3,4,5])
  end

  # def teardown
  # end

end
