require 'test/unit'
require './upg2.rb'

class TestSem < Test::Unit::TestCase
  def test_two
    par = Log_expr.new
    par.log(false)
    par = par.logParser
    
    assert_equal(true, par.parse('true'))
    assert_equal(false, par.parse('false'))

    assert_equal(false, par.parse('(not true)'))
    assert_equal(true, par.parse('(not false)'))
    
    par.parse('(set a true)')
    par.parse('(set b false)')
    assert_equal(true, par.parse('(or a b)'))
    assert_equal(false, par.parse('(or false b)'))

    assert_equal(false, par.parse('(and a b)'))
    assert_equal(true, par.parse('(and true a)'))    

  end

end
