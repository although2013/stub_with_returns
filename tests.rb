require 'minitest/autorun'
require './mock'

class MockTest < MiniTest::Unit::TestCase

  def test_class_stubs
    A.stubs(:foo).returns(2)
    assert_equal 2, A.foo
  end

  def test_class_stubs_with_params
    A.stubs(:bar).with(3).returns(2)
    assert_equal 2, A.bar(3)
    assert_raises(RuntimeError) { A.bar(4) }
  end

  def test_class_stubs_will_not_affect_here
    assert_equal 6, A.bar(3)
  end

  def test_instance_stubs
    a = A.new
    a.stubs(:foo).returns(1)
    assert_equal 1, a.foo
  end

  def test_instance_stubs_with_params
    a = A.new
    a.stubs(:bar).with(4).returns(0)
    assert_equal 0, a.bar(4)
    assert_raises(RuntimeError) { a.bar(3) }
  end

  def test_all_instances
    A.all_instances.stubs(:foo).returns(7)
    a = A.new
    assert_equal 7, a.foo
  end

end

class A

  def self.foo
    3
  end

  def self.bar param
    4
  end

  def foo
    5
  end

  def bar params
    6
  end

end