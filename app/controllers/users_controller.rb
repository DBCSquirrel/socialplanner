class UsersController < ApplicationController
  skip_before_filter :require_login!

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to root_path
  end

end