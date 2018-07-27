require 'csv'

class MovieExporterJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    sleep(5) unless Rails.env.test? # this emulates long export, do not remove
    MovieExportMailer.send_file(user_id, csv).deliver_now
  end

  private

  def csv
    CSV.generate csv_options do |csv|
      Movie.all.each do |movie|
        csv << [movie.title, movie.description]
      end
    end
  end

  def csv_options
    {
        write_headers: true,
        headers: %w[title description],
        col_sep: ";"
    }
  end
end
