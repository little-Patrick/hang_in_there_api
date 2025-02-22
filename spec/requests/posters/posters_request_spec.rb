require "rails_helper"

RSpec.describe "Posters endpoints", type: :request do
  before(:each) do
    @poster_regret = Poster.create!(name: "REGRET",
                                    description: "Hard work rarely pays off.",
                                    price: 89.00,
                                    year: 2018,
                                    vintage: true,
                                    img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    @poster_misery = Poster.create!(name: "Misery",
                                    description: "Test 2",
                                    price: 50.01,
                                    year: 2001,
                                    vintage: false,
                                    img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    @poster_ok = Poster.create!(name: "okayish",
                                description: "hellow test 3",
                                price: 112.90,
                                year: 1985,
                                vintage: true,
                                img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    @poster_test = Poster.create(name: "Test",
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

    posters[:data].each do |poster|
      expect(poster).to have_key(:id)
      expect(poster[:id]).to be_an(Integer)

      expect(poster[:attributes]).to have_key(:name)
      expect(poster[:attributes][:name]).to be_a(String)

      expect(poster[:attributes]).to have_key(:description)
      expect(poster[:attributes][:description]).to be_a(String)

      expect(poster[:attributes]).to have_key(:price)
      expect(poster[:attributes][:price]).to be_a(Float)

      expect(poster[:attributes]).to have_key(:year)
      expect(poster[:attributes][:year]).to be_a(Integer)

      expect(poster[:attributes]).to have_key(:vintage)
      expect(poster[:attributes][:vintage]).to be_in([true, false])

      expect(poster[:attributes]).to have_key(:img_url)
      expect(poster[:attributes][:img_url]).to be_a(String)
    end
  end

  it "can send one poster #show" do
    get "/api/v1/posters/#{@poster_misery.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200) 

    puts response.body 

    update_poster = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(update_poster[:id]).to be_a(Integer) 
    expect(update_poster[:type]).to eq("poster")

    poster = update_poster[:attributes] 

    expect(poster).to have_key(:name)
    expect(poster[:name]).to be_a(String)

    expect(poster).to have_key(:description)
    expect(poster[:description]).to be_a(String)

    expect(poster).to have_key(:price)
    expect(poster[:price]).to be_a(Float)

    expect(poster).to have_key(:year)
    expect(poster[:year]).to be_a(Integer)

    expect(poster).to have_key(:vintage)
    expect(poster[:vintage]).to be(true).or be(false)

    expect(poster).to have_key(:img_url)
    expect(poster[:img_url]).to be_a(String)
  end

  it "#create" do
    poster_params = { poster: { name: "New Poster", description: "Cool poster", price: 19.99, year: 1995, vintage: true, img_url: "https://example.com/poster.jpg" } }

    post "/api/v1/posters", params: poster_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    created_poster = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(created_poster[:type]).to eq("poster")
    expect(created_poster[:attributes][:name]).to eq("New Poster")
  end

  it "#update" do
    patch "/api/v1/posters/#{@poster_misery.id}", params: { poster: { name: "updated_poster" } }

    expect(response).to be_successful
    expect(response.status).to eq(200) 

    puts response.body 

    update_poster = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(update_poster[:id]).to be_a(Integer) 
    expect(update_poster[:type]).to eq("poster")

    poster = update_poster[:attributes] 

    expect(poster).to have_key(:name)
    expect(poster[:name]).to be_a(String)

    expect(poster).to have_key(:description)
    expect(poster[:description]).to be_a(String)

    expect(poster).to have_key(:price)
    expect(poster[:price]).to be_a(Float)

    expect(poster).to have_key(:year)
    expect(poster[:year]).to be_a(Integer)

    expect(poster).to have_key(:vintage)
    expect(poster[:vintage]).to be(true).or be(false)

    expect(poster).to have_key(:img_url)
    expect(poster[:img_url]).to be_a(String)

    expect(poster[:name]).to eq("updated_poster")
  end

  it "#destroy" do
    delete "/api/v1/posters/#{@poster_misery.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)

  end
end
