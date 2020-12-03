require "advent_of_code_2020/day3"

RSpec.describe Day3::Grid do
  let(:fixture) {
    File.new("input/day3_fixture.txt").read
  }

  subject {
    described_class.new(fixture)
  }

  describe "#rows" do
    it "returns the amount of rows for given grid" do
      expect(subject.rows).to eq(11)
    end
  end
  
  describe "#point" do
    it "returns entity for given vector within grid length" do
      expect(subject.point(0, 0)).to eq(:open_square)
      expect(subject.point(0, 1)).to eq(:tree)
    end

    it "returns entity for given vector outside grid length" do
      expect(subject.point(11, 0)).to eq(:open_square)
      expect(subject.point(11, 1)).to eq(:tree)

      expect(subject.point(13, 0)).to eq(:tree)
      expect(subject.point(24, 0)).to eq(:tree)
    end

    it "do not let vector outside vertical grid" do
      expect(subject.point(0, 11)).to eq(:void)
    end
  end

end

RSpec.describe Day3::Toboggan do
  subject {
    described_class.new(0, 0)
  }

  describe "#move" do
    it "moves 3 to the right, 1 down" do
      subject.move

      expect(subject.x).to eq(3)
      expect(subject.y).to eq(1)

      subject.move

      expect(subject.x).to eq(6)
      expect(subject.y).to eq(2)
    end
  end
end

RSpec.describe Day3::Ride do
  let(:fixture) {
    File.new("input/day3_fixture.txt").read
  }

  subject {
    described_class.new(
      Day3::Grid.new(fixture),
      Day3::Toboggan.new(0, 0)
    )
  }

  describe "#run" do
    it "runs through the grid and count how many collided trees" do
      subject.run

      expect(subject.collided_trees_count).to eq(7)
    end
  end

end