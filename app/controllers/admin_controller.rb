class AdminController < ApplicationController
    before_action :authorize_admin!
    def index
        # @users = User.all
      end
      def manage_users
        @users = User.all
      end
    
      def block_user
        user = User.find(params[:id])
        user.update(blocked: true)
        redirect_to manage_users_admin_path, notice: 'User blocked successfully.'
      end
    
      def unblock_user
        user = User.find(params[:id])
        user.update(blocked: false)
        redirect_to manage_users_admin_path, notice: 'User unblocked successfully.'
      end
      def show_user
        @user = User.find(params[:id])
      end
    
      def edit
        # @user = User.find(params[:id])
      end
   
      def update
        # @user = User.find(params[:id])
        # if @user.update(user_params)
        #   redirect_to admin_path(@user), notice: "User updated successfully"
        # else
        #   render :edit
        # end
      end
    
      def destroy 
        # @user = User.find(params[:id])
        # @user.destroy
        # redirect_to admin_index_path, notice: "User deleted successfully"
      end
    
    
     
    
end
