class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :profile, :destroy, :update, :index, :show]
  

    def profile 
      render json: {user: UserSerializer.new(current_user)}, status: :accepted 
    end

    def index
      users = User.all
      render json: users, include: [:followers, :followees, :fave_shows, :shows]
    end

    def show
      user = User.find(params[:id])

      render json: user, include: [:followers, :followees, :fave_shows, :shows]
    end

    def create
        @user = User.create(user_params)
        
        if @user.valid?
          @token = encode_token({user_id: @user.id})
          render json: { user: UserSerializer.new(@user), jwt: @token}, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def destroy
      user = User.find(params[:id])
      user.destroy()
    end
     
    def update
      user = User.find(params[:id])
      user.update(update_params)

      if user.valid?
        render json: user
      else
        render json: { error: 'failed to update user' }, status: :not_acceptable
      end
    end


      private
      
      def update_params
        params.require(:user).permit(:username, :email, :avatar)
      end
      
      def user_params
        params.require(:user).permit(:username, :password, :email, :avatar)
      end
end