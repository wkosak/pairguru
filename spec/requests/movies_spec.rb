require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    let!(:movies) { create_list(:movie, 2) }

    context 'html format' do
      it "displays right title" do
        visit "/movies"
        expect(page).to have_selector("h1", text: "Movies")
      end
    end

    context 'JSON' do
      it "displays basic attributes" do
        visit '/movies.json'
        expect(page.body).to match(/#{movies.first.title}/)
        expect(page.body).to_not match(/#{movies.first.description}/)
      end
    end
  end

  describe "view movie" do
    let!(:movie) { create(:movie) }

    context 'html format' do
      it "displays right title" do
        visit "/movies/#{movie.id}"
        expect(page).to have_selector("h1", text: movie.title)
      end
    end

    context 'JSON' do
      it "displays movie attributes" do
        visit "/movies/#{movie.id}.json"
        expect(page.body).to match(/#{movie.title}/)
        expect(page.body).to match(/#{movie.description}/)
      end
    end
  end
end
