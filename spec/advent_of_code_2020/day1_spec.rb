require 'spec_helper'

RSpec.describe AdventOfCode2020::Day1 do
  describe "#call" do
    subject {
      described_class.new
    }

    it "finds the two entry values that sum to 2020 and returns their multiply value" do
      fixture = [1721, 979, 366, 299, 675, 1456]

      # 1721 * 299 = 514579
      expect(subject.call(fixture)).to eq(514579)
    end
  end
end