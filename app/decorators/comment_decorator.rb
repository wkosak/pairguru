class CommentDecorator < Draper::Decorator
  delegate_all

  def author_and_date
    "#{user.name} added #{h.time_ago_in_words created_at} ago"
  end
end
