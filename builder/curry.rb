class BeefCurry
  attr_accessor :beef, :roux, :water

  def initialize
    @beef = 0
    @roux = 0
    @water = 0
  end
end

class PorkCurry
  attr_accessor :pork, :roux, :water

  def initialize
    @pork = 0
    @roux = 0
    @water = 0
  end
end

class CurryBuilder
  attr_accessor :curry

  def add_roux(amount)
    @curry.roux += amount
  end

  def add_water(amount)
    @curry.water += amount
  end
end

class BeefCurryBuilder < CurryBuilder
  def initialize
    @curry = BeefCurry.new
  end

  def add_meet(amount)
    @curry.beef += amount
  end
end

class PorkCurryBuilder < CurryBuilder
  def initialize
    @curry = PorkCurry.new
  end

  def add_meet(amount)
    @curry.pork += amount
  end
end

class Director
  def constract(builder)
    builder.add_meet( 400 )
    builder.add_water( 1200 )
    builder.add_roux( 140 )
    p builder.curry
  end
end

director = Director.new
director.constract(BeefCurryBuilder.new)
director.constract(PorkCurryBuilder.new)
