class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @user.id

    @comment.save ? (redirect_to user_post_path(@post.user.id, @post.id)) : (render :template => 'posts/show')
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete

    redirect_to user_post_path(@post.user.id, @post.id)
  end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
