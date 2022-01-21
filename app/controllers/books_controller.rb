class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to books_path(@book), notice: 'You have created book succesfully. '
    else
      @books = Book.all
      render 'index', notice: 'errors prohibited this obj from being saved:'
    end

  end
end

  def index
    @user = current_user
    @books = Book.all
    @book.new
  end

  def show
  end

  def edit
   @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id]) #データを一件取得
    book.destroy #データを削除
    redirect_to books_path #投稿一覧画面へ
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end