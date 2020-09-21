class Api::V1::FaveShowsController < ApplicationController
    skip_before_action :authorized

    def index
        fave_shows = FaveShow.all
        # faves = FaveShow.all.map{|fave| fave.show}
        render json: fave_shows
    end

    def create
        @fave_show = FaveShow.create(fave_params)
        # @show = @fave_show.show
        render json: @fave_show, include: [:show]
    end

    def destroy
        fave_shows = FaveShow.find(params[:id])
        fave_shows.destroy()
    end

    private
      
      def fave_params
        params.require(:fave_show).permit(:user_id, :show_id)
      end

end