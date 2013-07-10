class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def search
    movie = Movie.new
    imovie = Imdb::Search.new(params[:name]).movies
    movie.name = imovie.title
    movie.plot = imovie.plot
    movie.save
    redirect_to "/movies/display/#{movie.name}"
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def display
    @imovies = Imdb::Search.new(params[:title]).movies
  end

  def individual
    @movie = Imdb::Search.new(params[:id]).movies.first
  end

end