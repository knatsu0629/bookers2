class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    @user = current_user
  
    if @book.save
     redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
    redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      render :edit
    end
  end



  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
     @book.destroy
    end
      redirect_to books_path
  end
    

 private

 def book_params
   params.require(:book).permit(:title, :body)
 end
end