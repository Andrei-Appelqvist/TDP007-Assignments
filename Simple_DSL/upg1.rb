class Person
  def initialize(brand, post_number, licence_years, gender, age)
    @br = brand
    @pn = post_number
    @ly = licence_years
    @gn = gender
    @ag = age
    @points = 0
  end

  def evaluatePolicy(rules)
    file = File.read(rules)
    self.instance_eval(file)
    if @brand.include?(@br)
      @points += @brand[@br]
    end
    if @post_number.include?(@pn)
      @points += @post_number[@pn]
    end
    @points += @licence_years.select{|years| years === @ly}.values.first
    @points += @gender[@gn]
    @points += @age.select{|years| years === @ag}.values.first

    rules.each{|r|
      if r[0]
        puts "true"
        @points = @points * r[1]
      end
    }
    @points
  end

end

ruby = Person.new("Fiat", "58937", 13, "F", 58)
puts ruby.evaluatePolicy("rules.rb")
