require "rails_helper"
# require 'spec_helper'

describe MovieDetails do
  let(:movie) { create :movie, title: 'Star Wars V' }

  context 'call method', vcr: { cassette_name: 'pairguru-api/movies' } do
    subject { described_class.new(movie).call }

    it 'return movie rating' do
      expect(subject.rating).to eq(8.8)
    end

    it 'return movie poster' do
      expect(subject.poster).to eq(described_class::POSTER_URL+'/star_wars_v.jpg')
    end

    context 'when movie title not recognized' do
      let(:movie) { create :movie, title: 'Klan' }

      it 'return false' do
        expect(subject.successs?).to be_falsey
      end

      it 'return error message' do
        expect(subject.message).to eq("Couldn't find Movie")
      end

      it 'return movie rating' do
        expect(subject.rating).to be_nil
      end
    end
  end
end
