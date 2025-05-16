class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def create 
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item, notice: "Item created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item updated!"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Item deleted!"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user!
    redirect_to items_path, alert: "Not authorized" unless @item.user == current_user
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end
