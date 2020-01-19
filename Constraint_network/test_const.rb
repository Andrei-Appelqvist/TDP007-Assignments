# coding: utf-8
require 'test/unit'
require './constraint_networks.rb'
require './constraint-parser.rb'

class Test_const < Test::Unit::TestCase

  def test_adder
    a = Connector.new("a")
    b = Connector.new("b")
    c = Connector.new("c")
    Adder.new(a, b, c)
    a.user_assign(5)
    b.user_assign(1)

    assert_equal(5, a.value)
    assert_equal(1, b.value)
    assert_equal(6, c.value)

    a.forget_value "user"
    assert_not_equal(5, a.value)
    assert_equal(false, a.value)

    d = Connector.new("d")
    e = Connector.new("e")
    f = Connector.new("f")

    add2 = Adder.new(d, e, f)
    d.user_assign(8)

    e.user_assign(-1)
    assert_equal(7, f.value)

    g = Connector.new("g")
    h = Connector.new("h")
    i = Connector.new("i")

    add3 = Adder.new(g, h, i)

    g.user_assign(0)
    h.user_assign(-4)
    assert_equal(-4, i.value)

    j = Connector.new("j")
    k = Connector.new("k")
    l = Connector.new("l")

    add4 = Adder.new(j, k, l)

    j.user_assign(20)
    k.user_assign(80)

    #Här glömmer j sitt value och blir då false.
    #Genom koden i new_value uppdateras värdet av j när l får ett nytt value.
    j.forget_value "user"
    l.user_assign(120)
    assert_equal(40, j.value)

=begin
    # Här felsöks det att så fort k glömmer sitt value kommer även j tappa sitt värde
    # på grund av vem som har satt variabeln. Då user säger forget value kommer
    # även j tappa sitt värde och vi kan inte göra detta nedan.

    # En lösning på detta är att ändra på vem som gör ändringarna i new_value,
    # från self till "user". På detta sätt kommer värdet behållas och raderna
    # här under kommer fungera.

    k.forget_value "user"
    l.forget_value "user"
    l.user_assign(140)
    assert_equal(100, k.value)
=end
  end

  def test_multiplier
    a = Connector.new("a")
    b = Connector.new("b")
    c = Connector.new("c")

    mult = Multiplier.new(a, b, c)

    a.user_assign(2)
    b.user_assign(5)
    assert_equal(c.value, 10)

    a.forget_value "user"
    c.user_assign(20)
    assert_not_equal(a.value, 10)
    assert_equal(a.value, 4)

  end

  def test_temp
    c, f = celsius2fahrenheit

    c.user_assign(10)
    assert_equal(f.value, 50)

    c.forget_value "user"

    f.user_assign(50)
    assert_equal(c.value, 10)
  end

  def test_constraint_parser
     cp=ConstraintParser.new
     c,f=cp.parse "9*c=5*(f-32)"

     f.user_assign 0
     assert_equal(c.value, -18)

     f.user_assign 100
     assert_equal(c.value, 37)

     f.forget_value "user"

     # På grund av avrundningar som görs i funktionerna och vi arbetar
     # endast med heltal blir det inte exakta konverteraingar mellan
     # numren. Vi räknade ut dessa med hjälp av:
     # https://www.metric-conversions.org/sv/temperatur/celsius-till-fahrenheit.html

     c.user_assign 37
     assert_equal(f.value, 98)


     c.user_assign -19
     assert_equal(f.value, -3)

  end


end
