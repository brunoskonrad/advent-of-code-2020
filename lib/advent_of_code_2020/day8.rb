require "pry"

module Day8
  
  class BootCode
    attr_accessor :accumulator

    def initialize(program)
      @instructions = Instructions.new(program)
      @accumulator = 0

      @executed_instructions_lines = []

      @current_instruction_line = 0
      @next_instruction_line = 0
    end

    def run
      while can_execute?(@next_instruction_line)
        @current_instruction_line = @next_instruction_line
        @executed_instructions_lines << @current_instruction_line

        instruction = @instructions.get_instruction_at_line(@current_instruction_line)
        operation = instruction.operation.new(instruction.argument)

        @accumulator = operation.call(@accumulator)
        @next_instruction_line = operation.next_command(@current_instruction_line)
      end
    end

    private

    def can_execute?(line)
      !@executed_instructions_lines.include?(line)
    end
  end

  Instruction = Struct.new(:argument, :operation)

  class Instructions
    def initialize(program)
      @program = program.split(/\n/)
    end

    def get_instruction_at_line(line)
      parts = @program[line].split(" ")

      Instruction.new(parts[1], OPERATIONS[parts[0]])
    end
  end

  class Operator
    def initialize(argument)
      @argument = argument
    end

    def call(accumulator)
      raise "Not implemented"
    end

    def next_command(command_line)
      raise "Not implemented"
    end
  end

  class AccOperator < Operator
    def call(accumulator)
      accumulator + @argument.to_i
    end

    def next_command(command_line)
      command_line + 1
    end
  end

  class JmpOperator < Operator
    def call(accumulator)
      accumulator
    end

    def next_command(command_line)
      [command_line + @argument.to_i, 0].max
    end
  end

  class DefaultOperator < Operator
    def call(accumulator)
      accumulator 
    end

    def next_command(command_line)
      command_line + 1
    end
  end

  OPERATIONS = {
    "acc" => Day8::AccOperator,
    "jmp" => Day8::JmpOperator,
    "nop" => Day8::DefaultOperator,
  }.freeze

  def self.part_one
    input = File.new("input/day8_part1.txt").read
    boot_code = BootCode.new(input)

    boot_code.run

    p boot_code.accumulator
  end

end

Day8::part_one()