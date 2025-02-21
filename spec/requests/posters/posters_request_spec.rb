require "rails_helper"

RSpec.describe "Posters endpoints", type: :request do
  it "can send a list of posters" do
    get "/api/v1/posters"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)
    expect(posters[:data].count).to eq(4)

    posters.each do |poster|
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
end
