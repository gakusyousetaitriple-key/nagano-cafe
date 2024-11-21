class Public::AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_customer.addresses # 配送先一覧を取得
    @address = Address.new  # 新規登録用
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id  # ログイン中のユーザーIDを設定

    if @address.save
      redirect_to public_addresses_path, notice: '配送先を追加しました。'
    else
      @addresses = Address.all # 一覧を再取得
      flash.now[:alert] = '配送先の追加に失敗しました。'
      render :index
    end
  end

  def update
    if @address.update(address_params)
      redirect_to public_addresses_path, notice: '配送先を更新しました。'
    else
      flash.now[:alert] = '配送先の更新に失敗しました。'
      render :edit
    end
  end


  def destroy
    @address.destroy
    redirect_to public_addresses_path, notice: '配送先を削除しました。'
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:name, :post_code, :address)
  end

end
