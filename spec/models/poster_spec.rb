require "rails_helper"

RSpec.describe Poster, type: :model do
  describe "instance methods" do
    describe "#poster_sorting" do
      it "sorts tasks asc" do
        sorted_posters = Poster.poster_sorting('asc')
        expect(sorted_posters.first.name).to eq("REGRET")
      end
      it "sorts tasks desc" do
        sorted_posters = Poster.poster_sorting('desc')
        expect(sorted_posters.first.name).to eq("Test")
      end
    end
  end
end
