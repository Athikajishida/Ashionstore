class AdminController < ApplicationController
    before_action :authorize_admin!
     layout "admin_layouts"
    def index

      end
      def manage_users
        @users = User.all
      end
      def toggle_user
        user = User.find(params[:id])
        new_state = !user.blocked?
        user.update(blocked: new_state)
        if new_state
          redirect_to manage_users_admin_index_path, notice: 'User blocked successfully.'
        else
          redirect_to manage_users_admin_index_path, notice: 'User unblocked successfully.'
        end
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
