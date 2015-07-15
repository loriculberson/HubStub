class Seller::OrdersController < ApplicationController
  def index
    if current_user.slug == params[:slug]
      @user = User.find_by(slug: params[:slug])
      # @orders = current_user.orders.paginate(:page => params[:page], :per_page => 8)
    else
      redirect_to root_path
    end
  end

  def show
    if current_user.admin? || (current_user && current_user.slug == params[:slug])
      @order = Order.find_by(id: params[:id])
      @items = @order.items
    else
      redirect_to root_path
    end
  end
end
