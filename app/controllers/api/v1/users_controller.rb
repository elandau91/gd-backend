class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :profile]
  

    def profile 
      render json: {user: UserSerializer.new(current_user)}, status: :accepted 
    end

    # def index
    #   users = User.all
    #   render json: users, include: [:rounds]
    # end

    def create
        @user = User.create(user_params)
        
        if @user.valid?
          @token = encode_token({user_id: @user.id})
          render json: { user: UserSerializer.new(@user), jwt: @token}, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    # def destroy
    #   user = User.find(params[:id])
    #   user.destroy()
    # end
     
    # def update
    #   user = User.find(params[:id])
    #   user.update(avatar_params)
    #   render json: user
    # end


      private
      
    #   def avatar_params
    #     params.require(:user).permit(:avatar)
    #   end
      
      def user_params
        params.require(:user).permit(:username, :password, :email, :avatar)
      end
end