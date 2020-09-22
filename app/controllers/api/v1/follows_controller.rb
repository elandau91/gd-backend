class Api::V1::FollowsController < ApplicationController
    skip_before_action :authorized

    def create
        @follow = Follow.create(follow_params)
        # @show = @fave_show.show
        render json: @follow, include: [:followee]
    end

    def destroy
        follow = Follow.find(params[:id])
        follow.destroy()
    end

    private
      
      def follow_params
        params.require(:follow).permit(:follower_id, :followee_id)
      end

end