class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]


   def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
   end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books #@userがユーザー情報で、それにbooksモデルの本を紐付けている
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params)

    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render 'edit'
    end
  end



  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end


  def correct_user
    @user = User.find(params[:id])
    if current_user != @user　#ユーザーとそのidに紐付けられているユーザーが等しくなければ
      redirect_to user_path(current_user)
    end
  end
end
