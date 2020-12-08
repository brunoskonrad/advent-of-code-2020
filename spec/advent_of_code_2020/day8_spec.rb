require "spec_helper"
require "advent_of_code_2020/day8"

RSpec.describe Day8::AccOperator do
  subject {
    described_class.new(fixture)
  }

  describe "#call" do
    context "when argument is a positive number" do
      let(:fixture) { "+5" }
  
      it "increases counter with given value" do
        expect(subject.call(10)).to eq(15)
        expect(subject.call(0)).to eq(5)
        expect(subject.call(-5)).to eq(0)
        expect(subject.call(-10)).to eq(-5)
      end
    end

    context "when argument is a positive number" do
      let(:fixture) { "-5" }
  
      it "increases counter with given value" do
        expect(subject.call(10)).to eq(5)
        expect(subject.call(0)).to eq(-5)
        expect(subject.call(-5)).to eq(-10)
        expect(subject.call(-10)).to eq(-15)
      end
    end
  end

  describe "#next_command" do
    let(:fixture) { "+1" }

    it "returns next command number" do
      expect(subject.next_command(0)).to eq(1)
      expect(subject.next_command(10)).to eq(11)
    end
  end
end

RSpec.describe Day8::JmpOperator do
  subject {
    described_class.new(fixture)
  }

  describe "#call" do
    let(:fixture) { "+1" }

    it "returns same accumulator value" do
      expect(subject.call(10)).to eq(10)
      expect(subject.call(0)).to eq(0)
      expect(subject.call(-5)).to eq(-5)
      expect(subject.call(-10)).to eq(-10)
    end
  end

  describe "#next_command" do
    context "when argument is a positive number" do
      let(:fixture) { "+5" }
  
      it "jumps onwards to given value" do
        expect(subject.next_command(10)).to eq(15)
        expect(subject.next_command(0)).to eq(5)
      end
    end

    context "when argument is a positive number" do
      let(:fixture) { "-5" }
  
      it "jumps backwards to given value" do
        expect(subject.next_command(10)).to eq(5)
        expect(subject.next_command(5)).to eq(0)
        expect(subject.next_command(0)).to eq(0)
      end
    end
  end
end

RSpec.describe Day8::DefaultOperator do
  subject {
    described_class.new(fixture)
  }

  describe "#call" do
    let(:fixture) { "+1" }

    it "returns same accumulator value" do
      expect(subject.call(10)).to eq(10)
      expect(subject.call(0)).to eq(0)
      expect(subject.call(-5)).to eq(-5)
      expect(subject.call(-10)).to eq(-10)
    end
  end

  describe "#next_command" do
    let(:fixture) { "+1" }

    it "returns next command number" do
      expect(subject.next_command(0)).to eq(1)
      expect(subject.next_command(10)).to eq(11)
    end
  end
end
