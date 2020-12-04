require "spec_helper"
require "advent_of_code_2020/day4"

require "pry"

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

RSpec.describe Day4::Validator do
  subject {
    Day4::Validator
  }

  describe "#valid_year?" do
    it "returns false when year is not present" do
      expect(subject.valid_year?(nil, 2000..2010)).to eq(false)
    end

    it "retuns false when year is outside range" do
      expect(subject.valid_year?(1990, 2000..2010)).to eq(false)
      expect(subject.valid_year?(2020, 2000..2010)).to eq(false)
    end

    it "retuns true when year is inside range" do
      expect(subject.valid_year?(2000, 2000..2010)).to eq(true)
      expect(subject.valid_year?(2005, 2000..2010)).to eq(true)
      expect(subject.valid_year?(2010, 2000..2010)).to eq(true)
    end
  end

  describe "#valid_height?" do
    it "returns false when year is not present" do
      expect(subject.valid_height?(nil)).to eq(false)
    end

    it "validates heights in inches" do
      expect(subject.valid_height?('nope')).to eq(false)
    end

    it "validates heights in inches" do
      expect(subject.valid_height?('58in')).to eq(false)
      expect(subject.valid_height?('77in')).to eq(false)

      expect(subject.valid_height?('59in')).to eq(true)
      expect(subject.valid_height?('76in')).to eq(true)
      expect(subject.valid_height?('74in')).to eq(true)
    end

    it "validates heights in centimeters" do
      expect(subject.valid_height?('149cm')).to eq(false)
      expect(subject.valid_height?('194cm')).to eq(false)

      expect(subject.valid_height?('150cm')).to eq(true)
      expect(subject.valid_height?('193cm')).to eq(true)
    end
  end

  describe "#valid_hex_colour?" do
    it "returns false when year is not present" do
      expect(subject.valid_hex_colour?(nil)).to eq(false)
    end

    it "validates hex colour" do
      expect(subject.valid_hex_colour?('#0000000')).to eq(false)
      expect(subject.valid_hex_colour?('#00000')).to eq(false)
      expect(subject.valid_hex_colour?('#ghijlm')).to eq(false)

      expect(subject.valid_hex_colour?('#000000')).to eq(true)
      expect(subject.valid_hex_colour?('#abcdef')).to eq(true)
      expect(subject.valid_hex_colour?('#059def')).to eq(true)
    end
  end
  
  describe "#valid_eye_colour?" do
    it "returns false when year is not present" do
      expect(subject.valid_eye_colour?(nil)).to eq(false)
    end

    it "validates hex colour" do
      expect(subject.valid_eye_colour?('nope')).to eq(false)

      expect(subject.valid_eye_colour?('amb')).to eq(true)
      expect(subject.valid_eye_colour?('blu')).to eq(true)
      expect(subject.valid_eye_colour?('brn')).to eq(true)
      expect(subject.valid_eye_colour?('gry')).to eq(true)
      expect(subject.valid_eye_colour?('grn')).to eq(true)
      expect(subject.valid_eye_colour?('hzl')).to eq(true)
      expect(subject.valid_eye_colour?('oth')).to eq(true)
    end
  end

  describe "#valid_passport_number?" do
    it "returns false when year is not present" do
      expect(subject.valid_passport_number?(nil)).to eq(false)
    end

    it "validates hex colour" do
      expect(subject.valid_passport_number?('0000000001')).to eq(false)
      expect(subject.valid_passport_number?('00000001')).to eq(false)
      expect(subject.valid_passport_number?('1')).to eq(false)

      expect(subject.valid_passport_number?('000000001')).to eq(true)
      expect(subject.valid_passport_number?('000000011')).to eq(true)
      expect(subject.valid_passport_number?('000000111')).to eq(true)
      expect(subject.valid_passport_number?('000001111')).to eq(true)
      expect(subject.valid_passport_number?('000011111')).to eq(true)
      expect(subject.valid_passport_number?('000111111')).to eq(true)
      expect(subject.valid_passport_number?('001111111')).to eq(true)
      expect(subject.valid_passport_number?('011111111')).to eq(true)
      expect(subject.valid_passport_number?('111111111')).to eq(true)
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
  
  context "part 2, invalid passports" do
    let(:invalid_passports) {
      Day4::LoadPassports.call(
        File.new("fixtures/day4_invalid_passports.txt").read
      )
    }

    it "please work in future" do
      invalid_passports.each do |document|
        subject = described_class.new(document)
        expect(subject.valid?).to eq(false)
      end
    end
  end

  context "part 2, valid passports" do
    let(:valid_passports) {
      Day4::LoadPassports.call(
        File.new("fixtures/day4_valid_passports.txt").read
      )
    }

    it "is it working?" do
      valid_passports.each do |document|
        subject = described_class.new(document)

        expect(subject.valid?).to eq(true)
      end
    end
  end

end
