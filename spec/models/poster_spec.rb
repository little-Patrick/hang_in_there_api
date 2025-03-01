require "rails_helper"

RSpec.describe Poster, type: :model do
  before(:each) do
    Poster.create!(name: "REGRET",
                  description: "Hard work rarely pays off.",
                  price: 89.00,
                  year: 2018,
                  vintage: true,
                  img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    Poster.create!(name: "Misery",
                  description: "Test 2",
                  price: 50.01,
                  year: 2001,
                  vintage: false,
                  img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    Poster.create(name: "okayish",
                  description: "hellow test 3",
                  price: 112.90,
                  year: 1985,
                  vintage: true,
                  img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    Poster.create(name: "Test",
                  description: "test description",
                  price: 217.92,
                  year: 1999,
                  vintage: false,
                  img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
  end

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

  describe "#poster_filtering" do 
    it "filters by name" do
      sorted_posters = Poster.sort_names("e")
      expect(sorted_posters.count).to eq(3)
    end

    it "filters by max" do 
      sorted_posters = Poster.max_price(60)
      expect(sorted_posters.count).to eq(1)
    end

    it "filters by min" do
      sorted_posters = Poster.min_price(100)
      expect(sorted_posters.count).to eq(2)
    end
  end
end
