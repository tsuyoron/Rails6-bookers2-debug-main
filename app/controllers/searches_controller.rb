class SearchesController < ApplicationController
 before_action :authenticate_user!

  def search
    @range = params[:range]
    p "range"
    p @range

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      p "usersを通ったよ"
      p @users
      p "usersを通ったよ"

    else
      @books = Book.looks(params[:search], params[:word])
      p "booksを通ったよ"
      p @books
    end
  end

end
