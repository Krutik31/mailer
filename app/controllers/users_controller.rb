class UsersController < ApplicationController
  before_action :fetch_user, only: %i[update destroy edit]

  def index
    @users = User.all.order(id: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user, format: 'html').welcome_email.deliver_now
      UserMailer.with(user: @user, format: 'text').welcome_email.deliver_now
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    email = @user.email
    if @user.update(user_params)
      UserMailer.with(user: @user, past_email: email).change_email.deliver_now if email != @user.email
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile)
  end
end
