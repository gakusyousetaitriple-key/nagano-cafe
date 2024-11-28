class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @item = Item.new(is_active: true)
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: '商品を登録しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: '商品情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :introduction, :is_active, :genre_id, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  
end
