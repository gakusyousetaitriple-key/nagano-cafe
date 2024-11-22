class Public::HomesController < ApplicationController

def top
  # アイテムを取得する（新着順？）
  @items = Item.order(created_at: :desc).limit(4)

end

def about
end


end
