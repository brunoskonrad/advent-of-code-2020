require 'spec_helper'
require "advent_of_code_2020/day2"

RSpec.describe AdventOfCode2020::Day2::Password do
  describe "#valid?" do
    it "returns true if password matches its criteria" do
      fixture = "1-3 a: abcde"
      subject = described_class.new(fixture)

      expect(subject.valid?).to be(true)
    end

    it "returns false if password does not match its criteria" do
      fixture = "1-3 b: cdefg"
      subject = described_class.new(fixture)

      expect(subject.valid?).to be(false)
    end

    it "rename me" do
      fixture = "2-9 c: ccccccccc"
      subject = described_class.new(fixture)

      expect(subject.valid?).to be(true)
    end
  end
end

RSpec.describe AdventOfCode2020::Day2::CorporatePolicy do
  describe "#validate" do
    it "returns true if given string is valid" do
      subject = described_class.new("1-3 a")

      expect(subject.validate("abcde")).to be(true)
    end

    it "returns true if given string is valid" do
      subject = described_class.new("1-3 a")

      expect(subject.validate("defghi")).to be(false)
    end
  end
end

RSpec.describe 