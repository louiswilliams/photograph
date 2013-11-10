class MainController < ApplicationController
  def index
    if user_signed_in?
        redirect_to posts_path
    end
  end

  def about
  end

  def home

  end
end
