class ReviewsController < ApplicationController
  before_action :require_user_log_in?
  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new()
    @review.user_id = Current.user.id
  end
  def create
    @review = Review.new(review_params)
    @review.user_id = Current.user.id
    @review.movie_id = params[:movie_id].to_i
    if @review.save
      flash[:notice] = "Succefully added ratings and reviews"
      redirect_to :controller=>'movie', :action=> 'index'
    else
      flash[:alert] = "Something went wrong"
      redirect_to :controller=>'movie', :action=> 'index'
    end
  end
  private
  def review_params
    params.require(:review).permit(:content,:rating)
  end
  def require_user_log_in?
    if Current.user == nil
       redirect_to user_session_new_path, alert: "Please login first"
    elsif !Current.user.normal?
        flash[:alert] = "unauthorized access"
        redirect_to user_session_new_path, status: :unprocessable_entity
    end
  end
end
