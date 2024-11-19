class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all # 全ジャンルを取得
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id]) # 選択されたジャンルを取得
      @items = @genre.items.page(params[:page]).per(8) # ジャンルに紐づく商品を取得
    else
      @items = Item.page(params[:page]).per(8) # 全商品のページネーション
    end
  end

  def show
    @item = Item.find(params[:id]) # 商品詳細を取得
  end
end
