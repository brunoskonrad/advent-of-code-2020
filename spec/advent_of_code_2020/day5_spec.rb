require "spec_helper"
require "advent_of_code_2020/day5"

RSpec.describe Day5::Seat do
  subject {
    described_class.new(fixture)
  }

  context "when seat is 'FBFBBFFRLR'" do
    let(:fixture) { "FBFBBFFRLR" }

    it "#row is 44" do
      expect(subject.row).to eq(44)
    end

    it "#column is 5" do
      expect(subject.column).to eq(5)
    end

    it "#seat_id is 357" do
      expect(subject.seat_id).to eq(357)
    end
  end

  context "when seat is 'BFFFBBFRRR'" do
    let (:fixture) { "BFFFBBFRRR" }

    it "returns expected value" do
      expect(subject.row).to eq(70)
      expect(subject.column).to eq(7)
      expect(subject.seat_id).to eq(567)
    end
  end

  context "when seat is 'FFFBBBFRRR'" do
    let (:fixture) { "FFFBBBFRRR" }

    it "returns expected value" do
      expect(subject.row).to eq(14)
      expect(subject.column).to eq(7)
      expect(subject.seat_id).to eq(119)
    end
  end
  
  context "when seat is 'BBFFBBFRLL'" do
    let (:fixture) { "BBFFBBFRLL" }

    it "returns expected value" do
      expect(subject.row).to eq(102)
      expect(subject.column).to eq(4)
      expect(subject.seat_id).to eq(820)
    end
  end
end