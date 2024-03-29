class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      redirect_to @commentable
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to @commentable
  end

  def hide
    @comment = @commentable.comments.find(params[:id])
    @comment.hide
    redirect_to @commentable
  end

  # Voting
  def upvote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      redirect_to @commentable, notice: "Can't vote on your own comment" 
    else
      if current_user.voted_up_on? @comment
        redirect_to @commentable
      elsif current_user.voted_down_on? @comment
        @comment.upvote_by current_user
        @comment.user.increase_karma
        @comment.user.increase_karma
        @comment.user.increase_reputation
        @comment.user.increase_reputation
        redirect_to @commentable
      else
        @comment.upvote_by current_user
        @comment.user.increase_karma
        @comment.user.increase_reputation
        redirect_to @commentable
      end
    end
  end
  
  def downvote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      redirect_to @commentable, notice: "Can't vote on your own comment" 
    else
      if current_user.voted_down_on? @comment
        redirect_to @commentable
      elsif current_user.voted_up_on? @comment
        @comment.downvote_by current_user
        @comment.user.decrease_karma
        @comment.user.decrease_karma
        @comment.user.decrease_reputation
        @comment.user.decrease_reputation
        redirect_to @commentable
      else
        @comment.downvote_by current_user
        @comment.user.decrease_karma
        @comment.user.decrease_reputation
        redirect_to @commentable
      end
    end
  end

   private

     def comment_params
      params.require(:comment).permit(:body, :parent_id, :post_id)
    end
end