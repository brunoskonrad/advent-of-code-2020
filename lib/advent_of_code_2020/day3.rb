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

    def initialize(x, y, move_x = 3, move_y = 1)
      @x = x
      @y = y

      @move_x = move_x
      @move_y = move_y
    end

    def move
      @x += @move_x
      @y += @move_y
    end
  end

  class TobogganFactory
    def self.version_1
      Toboggan.new(0, 0, 1, 1)
    end

    def self.version_2
      Toboggan.new(0, 0, 3, 1)
    end

    def self.version_3
      Toboggan.new(0, 0, 5, 1)
    end

    def self.version_4
      Toboggan.new(0, 0, 7, 1)
    end

    def self.version_5
      Toboggan.new(0, 0, 1, 2)
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
      while vehicle_in_grid?
        tick
      end
    end

    private

    def vehicle_in_grid?
      @vehicle.y <= @grid.rows - 1
    end
  end

  def self.main
    input = File.new("input/day3.txt").read
    grid = Grid.new(input)

    ride1 = Ride.new(grid, TobogganFactory.version_1)
    ride2 = Ride.new(grid, TobogganFactory.version_2)
    ride3 = Ride.new(grid, TobogganFactory.version_3)
    ride4 = Ride.new(grid, TobogganFactory.version_4)
    ride5 = Ride.new(grid, TobogganFactory.version_5)

    rides = [ride1, ride2, ride3, ride4, ride5]

    rides.each(&:run)
    output = rides.map(&:collided_trees_count).reduce(1, &:*)

    p output
  end

end

Day3::main()