class Api::V1::LikesController < ApplicationController
  before_action :find_user, only: %i(like_post unlike_post check_like)
  before_action :find_post, only: %i(like_post unlike_post check_like)

  def get_current_user_id
    render json: current_user.id
  end

  def get_all_likes
    all_likes = Like.where(post_id: params[:id]).count()

    render json: all_likes
  end

  def like_post
    like = Like.new
    like.user_id = @user.id
    like.post_id = @post.id
    like.save
  end

  def unlike_post
    like = Like.where(user_id: @user.id).where(post_id: @post.id).first

    like.destroy
  end

  def check_like
    like = Like.where(user_id: @user.id).where(post_id: @post.id)

    render json: like.exists?
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
