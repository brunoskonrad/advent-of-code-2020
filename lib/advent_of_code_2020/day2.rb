module AdventOfCode2020
  module Day2

    # 2-4 p: vpkpp
    class Password
      def initialize(password_entry)
        password_parts = password_entry.split(":").map(&:strip)

        @corporate_policy = SledRentalPlaceCorporatePolicy.new(password_parts[0])
        @password = password_parts[1]
      end

      def valid?
        @corporate_policy.validate(@password)
      end
    end

    class SledRentalPlaceCorporatePolicy
      def initialize(policy)
        parts = policy.split(" ")

        @range = parts[0].split("-").map(&:to_i)
        @character = parts[1]
      end

      def validate(password)
        password
          .split("")
          .select { |c| c == @character }
          .count
          .between?(@range[0], @range[1])
      end
    end

    def self.main
      day2_input = File.new("input/day2.txt")
      
      output = day2_input
        .read
        .split(/\n/)
        .map(&:strip)
        .map { |password| Password.new(password) }
        .select(&:valid?)
        .count

      puts output
    end

  end
end

AdventOfCode2020::Day2::main()