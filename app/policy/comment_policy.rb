class CommentPolicy
  attr_reader :user, :movie, :comment

  def initialize(user, movie, comment)
    @user = user
    @movie = movie
    @comment = comment
  end

  def can_delete?
    user.id == comment.user_id
  end

  def can_create?
    Comment.where(user_id: user, movie_id: movie).empty?
  end
end