class Api::V1::ShowsController < ApplicationController
    skip_before_action :authorized

    def index
        shows = Show.all

        # faves = FaveShow.all.map{|fave| fave.show}
        render json: shows
    end

    def show
        show = Show.find(params[:id])
        # comments = show.comment_shows.users

        render json: show, include: [:song_refs, :comment_shows, :users]
    end

end