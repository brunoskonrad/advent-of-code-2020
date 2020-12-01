module AdventOfCode2020
  class Day1
    def call(entries)
      numbers = FindNumbers.new.find(entries)

      numbers[0] * numbers[1]
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