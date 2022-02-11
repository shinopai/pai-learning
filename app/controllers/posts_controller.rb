class PostsController < ApplicationController
  before_action :init_post, only: %i(new create)
  before_action :init_category, only: %i(new create)
  before_action :find_user, only: %i(create edit update show)
  before_action :find_post, only: %i(edit update destroy show)
  before_action :set_query, only: %i(index search)

  def index
    res = Post.all.order(created_at: :desc).page(params[:page]).per(20)
    @posts = res.joins(:user, :category).select('posts.*, users.name as user_name, users.user_image, users.id as user_id, categories.name')
  end

  def new
  end

  def create
    @post = @user.posts.new(post_params)
    @post.category_id = params[:category][:name]

    if @post.save
      flash[:success] = '新しい問題を投稿しました'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = '問題の内容を更新しました'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    flash[:success] = '問題を削除しました'
    redirect_to root_path
  end

  def search
    res = @query.result
    @posts = res.joins(:user, :category).select('posts.*, users.name as user_name, users.user_image, users.id as user_id, categories.name')

    render 'index'
  end

  def show
    @comment = Comment.new
  end

  private
  def post_params
    params.require(:post).permit(:title, :question, :answer)
  end

  def init_post
    @post = Post.new
  end

  def init_category
    @category = Category.new
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def set_query
    @query = Post.ransack(params[:q])
  end
end
