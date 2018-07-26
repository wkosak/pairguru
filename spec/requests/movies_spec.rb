require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "movies show" do
    before do
      allow_any_instance_of(MovieDetails).to receive(:call) { OpenStruct.new(rating: '8.8', poster: MovieDetails::POSTER_URL + '/star_wars_v.jpg') }
    end
    let(:movie) { create(:movie) }

    it "displays rating" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("h1", text: "Rating: 8.8")
    end
  end
end
