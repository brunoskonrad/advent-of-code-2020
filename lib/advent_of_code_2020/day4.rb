module Day4

  def self.parse_string_input_to_hash(string_input)
    # TODO refactor me later
    string_input.split(" ").reduce({}) do |acc, n|
      temp = n.split(":")

      acc[temp[0]] = temp[1]
      acc
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
      @document_information.include?("ecl") and
      @document_information.include?("pid") and
      @document_information.include?("eyr") and
      @document_information.include?("hcl") and
      @document_information.include?("byr") and
      @document_information.include?("iyr") and
      @document_information.include?("hgt")
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