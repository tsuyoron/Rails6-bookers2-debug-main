class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    #フォロー数とフォロワー数を表示するための追記
    # @posts = @user.posts.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(current_user.id.to_s)
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id.to_s), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  # フォロー一覧ページとフォロワー一覧ページ用のアクション
  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
