require "pry"

module Day8
  
  class BootCode
    attr_reader :accumulator

    def initialize(instructions)
      @instructions = instructions
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

    def run_whole_program?
      @instructions.count - 1 == @current_instruction_line
    end

    private

    def can_execute?(line)
      !@executed_instructions_lines.include?(line) && line < @instructions.count
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

    def count
      @program.count
    end
  end

  LineInstruction = Struct.new(:line, :instruction)

  class HijackedInstructions < Instructions
    
    attr_accessor :replace_at

    def count_lines_to_change
      jmp_nop_commands.count
    end

    def get_instruction_at_line(line)
      if hijacked_instruction.line == line
        parts = @program[line].split(" ")
        hijacked_operation = parts[0] == "jmp" ? "nop" : "jmp"

        Instruction.new(parts[1], OPERATIONS[hijacked_operation])
      else
        super
      end
    end

    def hijacked_instruction
      jmp_nop_commands[replace_at]
    end

    def jmp_nop_commands
      @jmp_nop_commands ||= @program
        .map.with_index { |instruction, index| LineInstruction.new(index, instruction) }
        .filter { |line| /jmp|nop/.match(line.instruction) }
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
    instructions = Instructions.new(File.new("input/day8.txt").read)
    boot_code = BootCode.new(instructions)

    boot_code.run

    puts boot_code.accumulator
  end

  def self.run_part_two(instructions, index)
    instructions.replace_at = index
    boot_code = BootCode.new(instructions)

    boot_code.run

    return boot_code.accumulator if boot_code.run_whole_program?
    Day8::run_part_two(instructions, index + 1) if instructions.count_lines_to_change > index
  end

  def self.part_two
    instructions = HijackedInstructions.new(File.new("input/day8.txt").read)
    result = Day8::run_part_two(instructions, 0)

    puts result
  end

end

Day8::part_two()
