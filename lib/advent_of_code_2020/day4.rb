require 'pry'

module Day4

  def self.parse_string_input_to_hash(string_input)
    # TODO refactor me later
    string_input.split(" ").reduce({}) do |acc, n|
      temp = n.split(":")

      acc[temp[0]] = temp[1]
      acc
    end
  end

  class Validator
    EYE_COLOURS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].freeze

    def self.valid_year?(year, valid_range)
      return false unless year

      valid_range.include?(year.to_i)
    end

    def self.valid_height?(height)
      return false unless height

      match = height.match(/(\d{2,3})(in|cm)/i)
      return false unless match

      entries = match.captures

      if entries[1] == "cm"
        (150..193).include?(entries[0].to_i)
      else
        (59..76).include?(entries[0].to_i)
      end
    end

    def self.valid_hex_colour?(colour)
      return false unless colour

      /^#[a-f0-9]{6}$/i.match?(colour)
    end

    def self.valid_eye_colour?(eye_colour)
      return false unless eye_colour

      EYE_COLOURS.include?(eye_colour)
    end

    def self.valid_passport_number?(passport_number)
      return false unless passport_number

      /^\d{9}$/i.match?(passport_number)
    end
  end

  class LoadPassports
    def self.call(batch_file)
      batch_file
        .split(/\n\n/)
        .map { |document_information| document_information.gsub(/\n/, " ") }
    end
  end

  class Document
    def initialize(document_information)
      @document_information = Day4::parse_string_input_to_hash(document_information)
    end

    def valid?
      valid_byr? and
      valid_iyr? and
      valid_eyr? and
      valid_hgt? and
      valid_hcl? and
      valid_ecl? and
      valid_pid?
    end

    def valid_byr?
      Validator.valid_year?(@document_information["byr"], 1920..2002)
    end

    def valid_iyr?
      Validator.valid_year?(@document_information["iyr"], 2010..2020)
    end

    def valid_eyr?
      Validator.valid_year?(@document_information["eyr"], 2020..2030)
    end

    def valid_hgt?
      Validator.valid_height?(@document_information["hgt"])
    end

    def valid_hcl?
      Validator.valid_hex_colour?(@document_information["hcl"])
    end

    def valid_ecl?
      Validator.valid_eye_colour?(@document_information["ecl"])
    end

    def valid_pid?
      Validator.valid_passport_number?(@document_information["pid"])
    end

  end

  def self.main
    list_of_documents = LoadPassports.call(
      File.new("input/day4.txt").read
    )

    output = list_of_documents
      .map { |document| Document.new(document) }
      .filter(&:valid?)
      .count

    p output
  end

end

Day4::main()