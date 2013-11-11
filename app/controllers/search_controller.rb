class SearchController < ApplicationController
  def user
    if params[:query]
        @results = User.where("name like ?","%#{params[:query]}%")
        render json: @results 
    end
  end
end
