class ElementsController < ApplicationController
  def create
    collection = Collection.find(params[:collection_id])
    post = Post.find(params[:post_id])
    user = post.user

    collection.posts << post

    session[:collection] = collection
    session[:post] = post
    session[:user] = user

    redirect_to show_notice_path
  end

  def show_notice
    render 'notice'
  end
end
