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
    @imovies = Imdb::Search.new(params[:title]).movies[0..9]

  end

  def add_fave
    @imovie = Imdb::Movie.new(params[:movie_id])
    movie = Movie.new
    movie.name = @imovie.title
    movie.year = @imovie.year
    movie.plot = @imovie.plot
    movie.mpaa_rating = @imovie.mpaa_rating
    @imovie.cast_members.slice(0,2).each do |actor|
      new = Actor.new
      new.name = actor
      new.save
      movie.actors << new
    end
    movie.save
    redirect_to '/movies'
  end

  def individual
    @movie = Imdb::Movie.new(params[:id])
  end

end