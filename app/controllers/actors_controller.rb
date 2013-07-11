class ActorsController < ApplicationController
   def index
     @actors = Actor.all
   end

  def show
    @actor = Actor.find(params[:id])
  end

   def remove
     @actor = Actor.find(params[:actor_id])
     @actor.destroy
     redirect_to '/actors'
   end
end