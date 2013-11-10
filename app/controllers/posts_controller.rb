class PostsController < ApplicationController
  before_filter :set_post, only: [:show,:update,:destroy]
  before_filter :authenticate_user!

  def index
    @posts = Post.where("user_id = ?",current_user.id)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @post = Post.new
  end

  def show
  end

  def update
  end

  def destroy
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

end
