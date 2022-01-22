class BooksController < ApplicationController

  before_action :authenticate_user!


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to books_path(@book), notice: 'You have created book succesfully. '
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render 'index', notice: 'errors prohibited this obj from being saved:'
    end

  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @book.new = Book.new
    @user = @book.user
  end

  def edit
   @book = Book.find(params[:id])
    if @book.user == current_user
     render 'edit'
    else
      redirect_to books_path
    end
  end


  def update
    @book = Book.fink(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book succesfully.'
    else
      render 'edit'
    end
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
end