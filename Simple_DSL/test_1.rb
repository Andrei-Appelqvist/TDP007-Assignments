require 'test/unit'
require './upg1.rb'

class TestSem < Test::Unit::TestCase
  def test_ett
    kalle = Person.new("Volvo", "58435", 2, "M", 32)
    assert_equal(kalle.evaluatePolicy("rules.rb"), 15.66)

    carl = Person.new("Trabant", "58937", 25, "M", 99)
    assert_equal(carl.evaluatePolicy("rules.rb"), 18)

    ruby = Person.new("Fiat", "58937", 13, "F", 58)
    assert_equal(ruby.evaluatePolicy("rules.rb"), 22.5)

  end
end
