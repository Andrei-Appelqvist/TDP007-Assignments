require 'test/unit'
require './constraint_networks.rb'

class Test_Constraint_Network < Test::Unit::TestCase
  def test_add
    #test_adder finns som exempel i constraint_networks.rb
    #Skapa Connector objekt
    a = Connector.new("a")
    b = Connector.new("b")
    c = Connector.new("c")
    Adder.new(a, b, c)
    a.user_assign(10)
    b.user_assign(5)
    puts "c = "+c.value.to_s
    a.forget_value "user"
    c.user_assign(20)
    # a should now be 15
    puts "a = " + a.value.to_s
    assert_equal(15, a.value)
    assert_equal(c.value-b.value, a.value)
    assert_equal(c.value-a.value, b.value)
    #Behöver nog ha fler tester när man assignar andra värden.


  end

  def test_mult
    a = Connector.new("a")
    b = Connector.new("b")
    c = Connector.new("c")
    Multiplier.new(a, b, c)
    a.user_assign(10)
    b.user_assign(5)
    puts "c = "+c.value.to_s
    a.forget_value "user"
    c.user_assign(20)
    # a should now be
    puts "a = " + a.value.to_s
    assert_equal(4, a.value)
    assert_equal(c.value/b.value, a.value)
    assert_equal(c.value/a.value, b.value)
    #Behöver nog ha fler tester när man assignar andra värden.

  end

#Behöver göra tester till celsius2fahrenheit funktionen
end
