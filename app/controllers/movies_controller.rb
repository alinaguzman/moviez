class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])

  end

  def display
    @imovies = Imdb::Search.new(params[:title]).movies[0..9]

  end

  def add_fave
    @imovie = Imdb::Movie.new(params[:movie_id])
    movie = Movie.new
    movie.name = @imovie.title
    movie.year = @imovie.year
    movie.plot = @imovie.plot
    movie.mpaa_rating = @imovie.mpaa_rating
    movie.rating = 50
    @imovie.cast_members.slice(0,2).each do |actor|
      new = Actor.new
      new.name = actor
      new.save
      movie.actors << new
    end
    movie.save
    redirect_to '/movies'
  end

  def vote_up
    movie = Movie.find(params[:id])
    movie.rating = params[:rating].to_i
    movie.rating += 30
    movie.save
    redirect_to movie
  end

  def vote_down
    movie = Movie.find(params[:id])
    movie.rating = params[:rating].to_i
    movie.rating -= 30
    movie.save
    redirect_to movie
  end

  def individual
    @movie = Imdb::Movie.new(params[:id])
  end

end