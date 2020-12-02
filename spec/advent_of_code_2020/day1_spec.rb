require 'spec_helper'

RSpec.describe AdventOfCode2020::Day1 do
  describe "#call" do
    subject {
      described_class.new
    }

    it "finds the two entry values that sum to 2020 and returns their multiply value" do
      expect(subject.call()).to eq(440979)
    end
  end
end

RSpec.describe AdventOfCode2020::FindNumbers do
  subject {
    described_class.new
  }

  describe "#find" do
    context "when looking for 2 numbers" do
      fixture = [1721, 979, 366, 299, 675, 1456]

      it "finds the two entry values that sum to 2020" do
        expect(subject.find(fixture, 2)).to eq([1721, 299])
      end
    end

    context "when looking for 3 numbers" do
      fixture = [1721, 979, 366, 299, 675, 1456]

      it "finds the three entry values that sum to 2020" do
        expect(subject.find(fixture, 3)).to eq([979,366, 675])
      end
    end
  end
end