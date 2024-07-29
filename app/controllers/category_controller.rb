class CategoryController < ApplicationController

  def index     
   if params[:category].present? && params[:category] != 'All'
      @movies = Movie.where(category: params[:category])
    else
      @movies = Movie.all
    end
    @categories = Movie.distinct.pluck(:category)
  end

  def search
    @movies = Movie.search(params[:search])
  end

end
