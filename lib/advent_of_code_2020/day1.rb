module AdventOfCode2020
  class Day1
    def call()
      entries = LoadInput.new.load_from_txt_file()
      numbers = FindNumbers.new.find(entries, 2)

      numbers[0] * numbers[1]
    end
  end

  class LoadInput
    def load_from_txt_file()
      day1_input = File.new("input/day1.txt")

      day1_input.read.split(/\n/).map(&:strip).map(&:to_i)
    end
  end

  class FindNumbers
    def find(entries, amount_of_numbers)
      case amount_of_numbers
      when 2
        find_two(entries)
      when 3
        find_three(entries)
      else
        []
      end
    end

    private

    def find_two(entries)
      # Please refactor me
      for entry in entries
        for y in entries
          if entry != y && entry + y == 2020
            return [entry, y]
          end
        end
      end
    end

    def find_three(entries)
      # Please refactor me
      for entry in entries
        for y in entries
          for z in entries
            if entry != y && entry != z && entry + y + z == 2020
              return [entry, y, z]
            end
          end
        end
      end
    end
  end
end
