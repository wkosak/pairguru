require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "movies export" do
    let(:user) { create :user }
    before do
      login_as(user, scope: :user)
    end
    it "add new Job" do
      expect {
        visit "/movies/export"
      }.to have_enqueued_job(MovieExporterJob).with(user.id)
    end
  end
end
