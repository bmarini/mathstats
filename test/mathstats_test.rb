require 'test/unit'
require 'mathstats'

class TC_MyTest < Test::Unit::TestCase
  def setup
    Array.send :include, Mathstats
  end
  
  def test_average_as_module
    assert_equal 3, [1,2,3,4,5].average
    assert_equal(6, [1,2,3,4,5].average {|n| n * 2 })
    assert_equal(0, [].average(0))
    assert_equal('empty', [].average('empty'))
    
    assert_equal(1.5, [1,2].average)
  end
  
  def test_average_as_class
    assert_equal 3, Mathstats::Lib.average([1,2,3,4,5])
    assert_equal(6, Mathstats::Lib.average([1,2,3,4,5]) {|n| n * 2 })
    assert_equal(0, Mathstats::Lib.average([], 0))
    assert_equal('empty', Mathstats::Lib.average([], 'empty'))
    
    assert_equal(1.5, Mathstats::Lib.average([1,2]))
  end

  def test_sum_as_module
    assert_equal 10, [1,2,3,4].sum
    assert_equal(20, [1,2,3,4].sum {|n| n * 2 })
    assert_equal(0, [].sum(0))
    assert_equal('empty', [].sum('empty'))
  end

  def test_sum_as_class
    assert_equal 15, Mathstats::Lib.sum([1,2,3,4,5])
    assert_equal(30, Mathstats::Lib.sum([1,2,3,4,5]) {|n| n * 2 })
    assert_equal(0, Mathstats::Lib.sum([], 0))
    assert_equal('empty', Mathstats::Lib.sum([], 'empty'))
    
    assert_equal(3, Mathstats::Lib.sum([1,2]))
  end
  
  def test_variance_as_module
    assert_equal 30, [4, 7, 13, 16].variance
    assert_equal 30, [4, 7, 13, 16].map {|n| 10**8 + n }.variance
    assert_equal 30, [4, 7, 13, 16].map {|n| 10**9 + n }.variance
  end

  def test_variance_as_class
    assert_equal 30, Mathstats::Lib.variance([4, 7, 13, 16])
    assert_equal 30, Mathstats::Lib.variance([4, 7, 13, 16].map {|n| 10**8 + n })
    assert_equal 30, Mathstats::Lib.variance([4, 7, 13, 16].map {|n| 10**9 + n })
  end
  
  def test_standard_deviation_as_module
    assert_equal 6, [3,7,7,19].standard_deviation({:population => :finite})
    assert_equal 6.93, ([3,7,7,19].standard_deviation * 100).round / 100.0
  end

  # def teardown
  # end

end
