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
    
      def user_list
        sort_attribute = 'id'
        sort_direction = params[:order] && params[:order]['0']['dir'] == 'desc' ? 'desc' : 'asc'
        if params[:order]
          order = {
            '0' => 'id',
            '1' => 'email'
          }
          sort_attribute = order[params[:order]['0']['column'].to_s]
        end
        if params[:search]["value"].present?
          search_term = params[:search]["value"].downcase
          search_params = 'id LIKE :search'
          search_params += ' OR email LIKE :search'
          asset_types = User.where(search_params, search: "%#{params[:search]["value"]}%").page(params[:page]).per(params[:length]).order("#{sort_attribute} #{sort_direction}").to_a
          total_count = User.where(search_params, search: "%#{params[:search]["value"]}%").all.count
        else
          users = User.order(sort_attribute => sort_direction).offset(params[:start])
          total_count = User.count
        end
        render json: {
          recordsTotal: total_count,
          recordsFiltered: total_count,
          length: total_count,
          data: users
        }
      end
     
    
end
