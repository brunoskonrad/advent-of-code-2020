module AdventOfCode2020
  class Day1
    def call()
      entries = LoadInput.new.load_from_txt_file()
      numbers = FindNumbers.new.find(entries)

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
    def find(entries)
      # Please refactor me
      for entry in entries
        for y in entries
          if entry == y
            # ignore
          else
            if entry + y == 2020
              return [entry, y]
            end
          end
        end
      end
    end
  end
end
