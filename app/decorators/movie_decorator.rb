class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def poster_image
    return h.image_tag cover unless details.poster
    h.image_tag details.poster, class: 'poster img-rounded'
  end

  def rating
    "Rating: #{details.rating || '-'}"
  end

  def plot
    details.plot
  end

  private

  def details
    @details ||= MovieDetails.new(object).call
  end
end
