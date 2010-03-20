require 'test/unit'
require 'mathstats'

class MathStatsTest < Test::Unit::TestCase
  def test_average_as_module
    Mathstats.attach_to(Array)
    assert_equal 3, [1,2,3,4,5].average
    assert_equal(6, [1,2,3,4,5].average {|n| n * 2 })
    assert_equal(0, [].average(0))
    assert_equal('empty', [].average('empty'))

    assert_equal(1.5, [1,2].average)
  end

  def test_average_as_class
    assert_equal 3, Mathstats.average([1,2,3,4,5])
    assert_equal(6, Mathstats.average([1,2,3,4,5]) {|n| n * 2 })
    assert_equal(0, Mathstats.average([], 0))
    assert_equal('empty', Mathstats.average([], 'empty'))

    assert_equal(1.5, Mathstats.average([1,2]))
  end

  def test_sum_as_module
    Mathstats.attach_to(Array)
    assert_equal 10, [1,2,3,4].sum
    assert_equal(20, [1,2,3,4].sum {|n| n * 2 })
    assert_equal(0, [].sum(0))
    assert_equal('empty', [].sum('empty'))
  end

  def test_sum_as_class
    assert_equal 15, Mathstats.sum([1,2,3,4,5])
    assert_equal(30, Mathstats.sum([1,2,3,4,5]) {|n| n * 2 })
    assert_equal(0, Mathstats.sum([], 0))
    assert_equal('empty', Mathstats.sum([], 'empty'))

    assert_equal(3, Mathstats.sum([1,2]))
  end

  def test_variance_as_module
    Mathstats.attach_to(Array)
    assert_equal 30, [4, 7, 13, 16].variance
    assert_equal 30, [4, 7, 13, 16].map {|n| 10**8 + n }.variance
    assert_equal 30, [4, 7, 13, 16].map {|n| 10**9 + n }.variance
  end

  def test_variance_as_class
    assert_equal 30, Mathstats.variance([4, 7, 13, 16])
    assert_equal 30, Mathstats.variance([4, 7, 13, 16].map {|n| 10**8 + n })
    assert_equal 30, Mathstats.variance([4, 7, 13, 16].map {|n| 10**9 + n })
  end

  def test_standard_deviation_as_module
    Mathstats.attach_to(Array)
    assert_equal 6, [3,7,7,19].standard_deviation({:population => :finite})
    assert_equal 6.93, ([3,7,7,19].standard_deviation * 100).round / 100.0
  end

end
