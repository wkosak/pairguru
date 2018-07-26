class MovieDetails

  PAIRGURU_API_ENDPOINT = 'https://pairguru-api.herokuapp.com/api/v1/'.freeze
  POSTER_URL = 'https://pairguru-api.herokuapp.com/'.freeze

  def initialize(movie)
    @movie = movie
  end

  def call
    fetch_data
  end

  private

  def fetch_data
    attributes = json_response['data']['attributes']
    OpenStruct.new(success?: true,
               rating: attributes['rating'],
               poster: POSTER_URL + attributes['poster'],
               plot: attributes['plot']
    )
  rescue URI::InvalidURIError => e
    Rails.logger.warn "Invalid URL: #{e.message}"
    OpenStruct.new(success?: false,
                   error: e.message
    )
  end

  def json_response
    url = PAIRGURU_API_ENDPOINT + 'movies/' + URI.encode(@movie.title)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end
