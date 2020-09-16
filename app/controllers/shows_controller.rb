class ShowsController < ApplicationController

    def index
        shows = Show.all
        render json: shows
    end

    def show
        show = Show.find(params[:id])
        render json: show, include: [:song_refs]
    end

end