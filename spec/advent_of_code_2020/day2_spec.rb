require 'spec_helper'
require "advent_of_code_2020/day2"

RSpec.describe AdventOfCode2020::Day2::Password do
  context "when using SledRentalPlaceCorporatePolicy" do
    subject {
      subject = described_class.new(
        fixture,
        AdventOfCode2020::Day2::SledRentalPlaceCorporatePolicy
      )
    }

    describe "#valid?" do
      context "when fixture is '1-3 a: abcde'" do
        let(:fixture) { "1-3 a: abcde" }

        it "returns true if password matches its criteria" do
          expect(subject.valid?).to be(true)
        end
      end

      context "when fixture is '1-3 b: cdefg'" do
        let(:fixture) { "1-3 b: cdefg" }

        it "returns false if password does not match its criteria" do
          expect(subject.valid?).to be(false)
        end
      end

      context "when fixture is '2-9 c: ccccccccc'" do
        let(:fixture) { "2-9 c: ccccccccc" }

        it "rename me" do
          expect(subject.valid?).to be(true)
        end
      end
    end
  end

  context "when using TobogganCorporatePolicy" do
    subject {
      described_class.new(
        fixture,
        AdventOfCode2020::Day2::TobogganCorporatePolicy
      )
    }

    describe "#valid?" do
      context "when fixture is '1-3 a: abcde'" do
        let(:fixture) { "1-3 a: abcde" }

        it "returns true if password matches its criteria" do
          expect(subject.valid?).to be(true)
        end
      end
  
      context "when fixture is '1-3 b: cdefg'" do
        let(:fixture) { "1-3 a: cdefg" }

        it "returns false if password does not match its criteria" do
          expect(subject.valid?).to be(false)
        end
      end
      
      context "when fixture is '2-9 c: ccccccccc'" do
        let(:fixture) { "2-9 c: ccccccccc" }

        it "returns false" do
          expect(subject.valid?).to be(false)
        end
      end
    end
  end
end

RSpec.describe AdventOfCode2020::Day2::SledRentalPlaceCorporatePolicy do
  describe "#validate" do
    it "returns true if given string is valid" do
      subject = described_class.new("1-3 a")

      expect(subject.validate("abcde")).to be(true)
    end

    it "returns false if given string is not valid" do
      subject = described_class.new("1-3 a")

      expect(subject.validate("defghi")).to be(false)
    end
  end
end

RSpec.describe AdventOfCode2020::Day2::TobogganCorporatePolicy do
  describe "#validate" do
    it "returns true if given string is valid" do
      subject = described_class.new("1-3 a")

      expect(subject.validate("abcde")).to be(true)
    end

    it "returns false if given string is not valid" do
      subject = described_class.new("1-3 b")

      expect(subject.validate("cdefg")).to be(false)
    end
  end
end

RSpec.describe 