require "rails_helper"

RSpec.describe "Posters endpoints", type: :request do
  before(:each) do
    @regret = Poster.create!(name: "REGRET",
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
  
  xit "can send a list of posters" do
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
    get "/api/v1/posters"
  end

  it "creates a new poster" do
    post "/api/v1/posters", params: { 
      poster: {
        name: "DARKNESS",
        description: "There is no light at the end of the tunnel.",
        price: 2354.00,
        year: 1873,
        vintage: true,
        img_url:  "https://images.unsplash.com/photo-1500206329404-5057e0aefa48?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGFya25lc3N8ZW58MHx8MHx8fDA%3D"
      } 
    } 

    expect(response).to be_successful
    poster = JSON.parse(response.body, symbolize_names: true)

    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(Integer)
    expect(poster[:attributes][:name]).to eq("DARKNESS")
    expect(poster[:attributes][:description]).to eq("There is no light at the end of the tunnel.")
    expect(poster[:attributes][:price]).to eq(2354.00)
    expect(poster[:attributes][:year]).to eq(1873)
    expect(poster[:attributes][:vintage]).to eq(true)
    expect(poster[:attributes][:img_url]).to eq("https://images.unsplash.com/photo-1500206329404-5057e0aefa48?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGFya25lc3N8ZW58MHx8MHx8fDA%3D")
  end

  it "#update" do
  
  end

  it "can destroy a poster" do
    expect(@regret).to be_a Poster
  
    delete "/api/v1/posters/#{@regret.id}"
  
    expect(response).to be_successful
    expect(response.status).to eq(204)
  end
end
