module AdventOfCode2020
  class Day1
    def call(entries)
      entries = find_two_enties(entries)

      entries[0] * entries[1]
    end

    private

    def find_two_enties(entries)
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