class UsersController < ApplicationController
	skip_before_filter :require_login!

	def new
		render 'new', :layout => 'registration'
	end
	
	def edit
	  @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to signout_path
  end
end