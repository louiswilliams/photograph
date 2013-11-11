class PostsController < ApplicationController
  before_filter :set_post, only: [:show,:update,:destroy,:like]
  before_filter :authenticate_user!

  def index
    @posts = Post.where("user_id = ?",current_user.id).order("id DESC")
    # @posts.each! do |post|
    #   post.image
    # end
    respond_to do |format|
      format.html
      format.json {render json: @posts}
    end
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
    if params[:post_id]
      @post = Post.find(params[:post_id])
    else
      @post = Post.find(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def like
    @like = Like.find_by_user_id_and_post_id(current_user.id,@post.id)
    
    if !@like
      @like = Like.new
      @like.user = current_user
      @like.post = @post
      respond_to do |format|
        if @like.save
          format.html { redirect_to posts_path}
          format.json { render json: @like, status: :created }
        else
          format.html { redirect_to posts_path }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    else
      @like.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.json { head :no_content}
      end
    end 
  end
end
