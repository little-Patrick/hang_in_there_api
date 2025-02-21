require "rails_helper"

RSpec.describe "Posters endpoints", type: :request do
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
  it "can send a list of posters" do
    get "/api/v1/posters"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)
    expect(posters[:data].count).to eq(4)

    posters[:data].each do |single_poster|
      expect(poster).to have_key(:id)
      expect(poster[:id]).to be_an(Integer)

      expect(poster).to have_key(:name)
      expect(poster[:name]).to be_a(String)

      expect(poster).to have_key(:description)
      expect(poster[:description]).to be_a(String)

      expect(poster).to have_key(:price)
      expect(poster[:price]).to be_a(Float)

      expect(poster).to have_key(:year)
      expect(poster[:year]).to be_a(Integer)

      expect(poster).to have_key(:vintage)
      expect(poster[:vintage]).to be_a(Boolean)

      expect(poster).to have_key(:img_url)
      expect(poster[:img_url]).to be_a(String)
    end
  end

  it "can send one poster #show" do
    get "api/v1/posters"
  end

  it "#create" do

  end

  it "#update" do
  
  end
end
