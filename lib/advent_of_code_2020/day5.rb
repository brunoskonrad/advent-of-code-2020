require "pry"

module Day5

  class Seat
    FRONT = "F"
    BACK = "B"
    LEFT = "L"
    RIGHT = "R"

    SEAT_CODE_REGEX = /^([F|B]{7})([L|R]{3})$/i

    def initialize(seat_code)
      @seat_code = seat_code
      @seat_code_parts = seat_code.match(SEAT_CODE_REGEX).captures
    end

    def row
      range = first_part
        .split("")
        .reduce(0..127) do |row_range, part|
          step = (row_range.max - row_range.min) / 2

          if part == FRONT
            row_range.min..(row_range.max - step)
          else
            (row_range.min + step)..row_range.max
          end
        end

      first_part[-1] == FRONT ? range.min : range.max
    end

    def column
      range = second_part
        .split("")
        .reduce(0..7) do |row_range, part|
          step = (row_range.max - row_range.min) / 2

          if part == LEFT
            row_range.min..(row_range.max - step)
          else
            (row_range.min + step)..row_range.max
          end
        end

      first_part[-1] == LEFT ? range.min : range.max
    end

    def seat_id
      row * 8 + column
    end

    private

    def first_part
      @seat_code_parts[0]
    end

    def second_part
      @seat_code_parts[1]
    end
  end

  def self.part_1
    seats = File.new("input/day5.txt").read.split(/\n/)
      .map { |seat| Seat.new(seat) }

    result = seats.sort do |a, b|
      a.seat_id <=> b.seat_id
    end

    binding.pry

    p result.inspect
  end

end

# Day5::part_1