class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_movie

  def create
    @comment = Comment.new comment_params
    if @comment.save
      flash[:success] = 'Comment added'
    else
      flash[:error] = "Comment can't be saved"
    end
    redirect_to movie_path(@movie)
  end

  def destroy
    @comment = @movie.comments.find params[:id]
    if policy.can_delete?
      @comment.destroy
      flash[:success] = 'Comment deleted!'
    else
      flash[:error] = 'No access!'
    end
    redirect_to movie_path(@movie)
  end

  private

  def comment_params
    params.require(:comment)
          .permit(:body)
          .merge({movie_id: @movie.id, user_id: current_user.id})
  end

  def find_movie
    @movie = Movie.find params[:movie_id]
  end

  def policy
    CommentPolicy.new(current_user, @comment)
  end
end
