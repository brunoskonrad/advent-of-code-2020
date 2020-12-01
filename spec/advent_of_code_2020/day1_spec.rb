require 'spec_helper'

fixture = [1721, 979, 366, 299, 675, 1456]

RSpec.describe AdventOfCode2020::Day1 do
  describe "#call" do
    subject {
      described_class.new
    }

    it "finds the two entry values that sum to 2020 and returns their multiply value" do
      expect(subject.call(fixture)).to eq(514579)
    end
  end
end

RSpec.describe AdventOfCode2020::FindNumbers do
  describe "#find" do
    subject {
      described_class.new
    }

    it "finds the two entry values that sum to 2020" do
      expect(subject.find(fixture)).to eq([1721, 299])
    end
  end
end