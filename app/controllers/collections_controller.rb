class CollectionsController < ApplicationController
  before_action :find_user, except: %i(index)
  before_action :find_collection, only: %i(show_contents destroy)
  before_action :authenticate_user!, only: %i(show_contents)

  def create
    collection = @user.collections.new(collection_params)
    collection.save

    redirect_to list_user_collections_path(@user)
  end

  def list
    @collections = @user.collections

    render 'collection_list'
  end

  def show_contents
    post_ids = Element.where(collection_id: @collection.id).pluck(:post_id)
    @posts = Post.where(id: post_ids)

    render 'contents'
  end

  def destroy
    @collection.destroy

    redirect_to list_user_collections_path(@user)
  end

  def index
    @collections = Collection.page(params[:page]).per(20)
  end


  private
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:title)
  end
end
