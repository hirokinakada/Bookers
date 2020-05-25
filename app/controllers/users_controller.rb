class UsersController < ApplicationController

 # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, only: [:edit,:show,:index]
# 編集画面表示、修正内容の更新アクション実行時はログインしているユーザーの場合のみ実行可とする。
  before_action :correct_user, only: [:edit, :update]


def index
	@users = User.all
	@booknew = Book.new
	@userpro = current_user
end

def show
	@booknew = Book.new
	@user = User.find(params[:id])
	@books = @user.books#ひもづけ
end

def edit
	@user = current_user

end

def update
	@user = User.find(params[:id])
	if @user.update(user_params)
	redirect_to user_path(@user.id),notice:"You have updated user successfully."
else
	render :edit
end
end

private
def user_params
	params.require(:user).permit(:name,:profile_image,:introduction)
end

	def correct_user
	user = User.find(params[:id])
	if current_user != user
	redirect_to user_path(current_user)
	end
	end

end
