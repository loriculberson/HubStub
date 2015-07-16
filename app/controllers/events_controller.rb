require "will_paginate/collection"

class EventsController < ApplicationController
  def index
    @items = Item.available.not_in_cart(session[:cart]).paginate(page: params[:page], per_page: 6)
    @events = @items.map(&:event).uniq
    @events = @events.select { |event| event.category.name == params[:category] } if params[:category]
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.active.not_in_cart(session[:cart])
  end

  def random
    if Event.count > 0
      offset = rand(Event.active.count)
      event = Event.active.offset(offset).first
      redirect_to event
    else
      redirect_to root_path
    end
  end
end


