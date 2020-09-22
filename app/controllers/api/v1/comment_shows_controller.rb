class Api::V1::CommentShowsController < ApplicationController
    skip_before_action :authorized

    def create
        @comment_show = CommentShow.create(comment_params)
        # @show = @fave_show.show
        render json: @comment_show, include: [:user]
    end

    def destroy
        comment_shows = CommentShow.find(params[:id])
        comment_shows.destroy()
    end

    private
      
      def comment_params
        params.require(:comment_show).permit(:user_id, :show_id, :content)
      end

end