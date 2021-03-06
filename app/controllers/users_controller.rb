class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(mypage)
  before_action :get_user

  def mypage
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報の更新が完了しました'
      redirect_to user_mypage_path(@user)
    else
      render 'edit'
    end
  end

  def get_all_posts
    @posts = @user.posts.page(params[:page]).per(20)

    render 'all_posts'
  end

  def get_all_likes
    @likes = @user.likes.page(params[:page]).per(20)

    render 'all_likes'
  end


  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
