class Api::V1::SongRefsController < ApplicationController
    skip_before_action :authorized

    def index
        songs = SongRef.all

        # faves = FaveShow.all.map{|fave| fave.show}
        render json: songs
    end

    # def show
    #     show = Show.find(params[:id])
    #     # comments = show.comment_shows.users

    #     render json: show, include: [:song_refs, :comment_shows, :users]
    # end

end