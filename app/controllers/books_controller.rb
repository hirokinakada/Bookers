class BooksController < ApplicationController

  #ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, only: [:edit,:show,:index]
  #編集画面表示、修正内容の更新アクション実行時はログインしているユーザーの場合のみ実行可とする。
  before_action :correct_user, only: [:edit, :update,:destroy]

def top #最初のページ
end

def about
end

def index
    @books = Book.all
    @booknew = Book.new
    @userpro = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book.id),notice:'You have creatad book successfully.'
  else
    @books = Book.all
    @booknew = Book.new
    @userpro =current_user
    render :index
  end
end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user #ひもづけ
    @userpro = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
 if @book.update(books_params)
    redirect_to book_path(@book.id),notice:'You have updated book successfully.'
  else
    @book.id = user_session #なんかわからんけどできた
    render :edit
end
end

def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end



  private
  def books_params
  	params.require(:book).permit( :title, :body )
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user != user
    redirect_to books_path
    end
  end
end
