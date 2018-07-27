class MovieExportMailer < ApplicationMailer
  def send_file(user_id, csv)
    user = User.find user_id
    attachments["movies.csv"] = {mime_type: 'text/csv', content: csv}
    mail(to: user.email, subject: "Your export is ready")
  end
end
