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
    @item = Item.find(params[:id])
    @cart_item = current_customer.cart_items.find_or_initialize_by(item_id: @item.id) # 修正箇所
  end
end
