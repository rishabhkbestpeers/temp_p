class MovieController < ApplicationController

    def index
        @movies = Movie.all
    end
    def show
        @movie = Movie.find(params[:id])
        @reviews = @movie.reviews
        @rating = totalrating(@movie.reviews)

    end
    def new
        @movie = Movie.new()
    end
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
          redirect_to user_admin_path, notice: "Movie successfully created!"
        else
            redirect_to user_admin_path, alert: "Movie not added!"
        end
    end
    def edit
        @movie = Movie.find(params[:id])    
    end
    def update
        @movie = Movie.find(params[:id])
        if @movie.update(movie_params)
          redirect_to user_admin_path, notice: "Movie successfully updated!"
        else
            flash[:alert] ="Something went wrong"
            redirect_to user_admin_path, status: :unprocessable_entity
        end
    end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to user_admin_path, notice: "Movie successfully deleted!"
    end
    private

    def movie_params
        params.require(:movie).permit(:id,:title, :release_date, :director, :cast, :about, :category)
    end

    def totalrating (reviews)
        count = 0
        total_rating = 0
        reviews.each do |rev|
            total_rating += rev.rating
            count += 1
        end

        if count==0
            return 0;
        else
            return total_rating/count
        end
    end
end
