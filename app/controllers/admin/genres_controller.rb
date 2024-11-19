class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params) # フォームから受け取ったデータでGenreを作成
    if @genre.save
      redirect_to admin_genres_path, notice: 'ジャンルを作成しました。' # 成功時
    else
      @genres = Genre.all # エラー時に一覧を再取得
      flash.now[:alert] = 'ジャンルの作成に失敗しました。'
      render :index # エラー時に一覧ページを再表示
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'ジャンルを更新しました。'
    else
      flash.now[:alert] = 'ジャンルの更新に失敗しました。'
      render :edit
    end
  end


  def genre_params
    params.require(:genre).permit(:name) # 必要なパラメータを許可
  end
end
