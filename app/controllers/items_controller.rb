class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def create 
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item, notice: "投稿が完了しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "削除しました！"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user!
    redirect_to items_path, alert: "権限がありません！" unless @item.user == current_user
  end

  def item_params
    params.require(:item).permit(:title, :description, :image)
  end
end
