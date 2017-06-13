class CommentsController < ApplicationController
  before_action :find_comment, only: [ :edit, :update, :destroy ]
  before_action :find_reivew, only: [ :create, :edit, :update, :destroy ]

  def create
    @comment = Comment.new(comment_params)
    @comment.review = @review
    @comment.user = current_user
    @comment.save
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    @comment.user = current_user
    @comment.update_event!

  end

  def destroy

    @comment.destroy
    redirect_to :back
  end

  def like
    @comment = Comment.find_by_friendly_id!(params[:id])
    current_user.create_action(:like, target: @comment)
    @comment.user = current_user
    @comment.like!
  end

  def unlike
    @comment = Comment.find_by_friendly_id!(params[:id])
    current_user.destroy_action(:like, target: @comment)
    @comment.user = current_user
    @comment.unlike!
  end

  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = current_user.comments.find_by_friendly_id!(params[:id])
  end

  def find_reivew
    @review = Review.find_by_friendly_id!(params[:review_id])
  end

end
