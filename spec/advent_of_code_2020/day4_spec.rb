require "spec_helper"
require "advent_of_code_2020/day4"

RSpec.describe "loading functions" do
  describe "#parse_string_input_to_hash" do
    it " " do
      fixture = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"

      expect(Day4::parse_string_input_to_hash(fixture)).to eq({
        "ecl" => "gry",
        "pid" => "860033327",
        "eyr" => "2020",
        "hcl" => "#fffffd",
        "byr" => "1937",
        "iyr" => "2017",
        "cid" => "147",
        "hgt" => "183cm",
      })
    end
  end
end

RSpec.describe Day4::LoadPassports do

  let(:fixture) {
    File.new("input/day4_fixture.txt").read
  }

  subject {
    described_class.call(fixture)
  }

  it "returns a list of pasports" do
    expect(subject).to eq([
      "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm",
      "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
      "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
      "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in",
    ])
  end

end

RSpec.describe Day4::Document do

  subject {
    described_class.new(document_fixture)
  }

  describe "#valid?" do
    context "first fixture set of data" do
      let(:document_fixture) { "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm" }
  
      it "returns true" do
        expect(subject.valid?).to eq(true)
      end
    end

    context "second fixture set of data" do
      let(:document_fixture) { "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929" }
  
      it "returns true" do
        expect(subject.valid?).to eq(false)
      end
    end

    context "third fixture set of data" do
      let(:document_fixture) { "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm" }
  
      it "returns true" do
        expect(subject.valid?).to eq(true)
      end
    end

    context "fourth fixture set of data" do
      let(:document_fixture) { "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in" }
  
      it "returns true" do
        expect(subject.valid?).to eq(false)
      end
    end
  end

end
