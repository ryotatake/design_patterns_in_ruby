class Car
  attr_accessor :body, :wheel, :engine

  def initialize(body = Body.new, wheel = Wheel.new, engine = Engine.new)
    @body = body
    @wheel = wheel
    @engine = engine
  end
end

class Body
  attr_accessor :size
  VALID_SIZE = [:small, :midium, :large]

  def initialize(size = :midium)
    if VALID_SIZE.include?(size)
      @size = size
    else
      raise
    end
  end
end

class Wheel
  attr_accessor :type
  VALID_TYPES = [:normal, :sport, :studless]

  def initialize(type = :normal)
    if VALID_TYPES.include?(type)
      @type = type
    else
      raise
    end
  end
end

class Engine
  attr_accessor :type
  VALID_TYPES = [:gasoline, :diesel, :hybrid]

  def initialize(type = :gasoline)
    if VALID_TYPES.include?(type)
      @type = type
    else
      raise
    end
  end
end

class CarBuilder
  attr_reader :car

  def initialize
    @car = Car.new
  end

  def body_size=(size)
    @car.body.size = size
  end

  def wheel_type=(type)
    @car.wheel.type = type
  end

  def engine_type=(type)
    @car.engine.type = type
  end
end

class SportsCarDirector
  def constract(builder)
    builder.body_size = :small
    builder.wheel_type = :sport
    p builder.car
  end
end

SportsCarDirector.new.constract(CarBuilder.new)
SportsCarDirector.new.constract(CarBuilder.new)

# builderを使わない場合。newだけでは少し複雑で分かりにくい。
p sports_car = Car.new(Body.new(:small), Wheel.new(:sport), Engine.new)
