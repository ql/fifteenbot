require './spec_helper.rb'

RSpec.describe Fifteen do
  before(:each) do
    @fifteen = Fifteen.new([5, 3, 11, 8, 15, 10, 2, 6, "_", 14, 9, 7, 4, 13, 1, 12])
  end

  describe "#inspect" do
    it "should be" do
      expect(@fifteen.inspect).to eq %Q( 5  3 11  8
15 10  2  6
 _ 14  9  7
 4 13  1 12)
    end
  end

  describe "#empty_pos" do
    it "should work" do
      expect(@fifteen.empty_pos).to eq([2, 0])
    end
  end


  describe "#slide" do
    it "should work" do
      expect(@fifteen.slide!(0,0)).not_to eq(@fifteen)
      expect(@fifteen.slide!(1,0)).not_to eq(@fifteen)
      expect(@fifteen.slide!(2,0)).not_to eq(@fifteen)
      expect(@fifteen.slide!(3,0)).not_to eq(@fifteen)

      expect(@fifteen.slide!(0,1)).to eq(@fifteen)
      expect(@fifteen.slide!(1,1)).to eq(@fifteen)
      expect(@fifteen.slide!(2,1)).not_to eq(@fifteen)
      expect(@fifteen.slide!(3,1)).to eq(@fifteen)

      expect(@fifteen.slide!(0,2)).to eq(@fifteen)
      expect(@fifteen.slide!(1,2)).to eq(@fifteen)
      expect(@fifteen.slide!(2,2)).not_to eq(@fifteen)
      expect(@fifteen.slide!(3,2)).to eq(@fifteen)

      expect(@fifteen.slide!(0,3)).to eq(@fifteen)
      expect(@fifteen.slide!(1,3)).to eq(@fifteen)
      expect(@fifteen.slide!(2,3)).not_to eq(@fifteen)
      expect(@fifteen.slide!(3,3)).to eq(@fifteen)
    end

    it "should alter state col" do
      puts @fifteen.inspect
      puts
      puts @fifteen.slide!(2,1).inspect
      puts
      puts @fifteen.slide!(2,2).inspect
      puts
      puts @fifteen.slide!(2,3).slide!(2,2).inspect
      puts
    end

    it "should alter state row" do
      puts '===='
      puts @fifteen.inspect
      puts
      puts @fifteen.slide!(0,0).inspect
      puts
      puts @fifteen.slide!(1,0).inspect
      puts
      puts @fifteen.slide!(2,0).inspect
      puts
      puts @fifteen.slide!(3,0).inspect
      puts
    end
  end
end
