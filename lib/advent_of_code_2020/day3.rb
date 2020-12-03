module Day3

  class Grid
    def initialize(input)
      @input = input.split(/\n/)
    end

    def point(x, y)
      return :void if y >= rows

      normalized_x = x % grid_width
      value = @input[y][normalized_x]

      if value == "#"
        :tree
      else
        :open_square
      end
    end

    def rows
      @input.length
    end

    private 

    def grid_width
      @input[0].length
    end
  end

  class Toboggan
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def move
      @x += 3
      @y += 1
    end
  end

  class Ride
    attr_reader :collided_trees_count

    def initialize(grid, vehicle)
      @grid = grid
      @vehicle = vehicle
      @collided_trees_count = 0
    end

    def tick
      @vehicle.move
      tile = @grid.point(@vehicle.x, @vehicle.y)

      @collided_trees_count += 1 if tile == :tree
    end

    def run
      while @vehicle.y <= @grid.rows - 1
        tick
      end
    end
  end

  def self.main
    input = File.new("input/day3.txt").read
    world = Ride.new(
      Grid.new(input),
      Toboggan.new(0, 0)
    )

    world.run

    p world.collided_trees_count
  end

end

Day3::main()