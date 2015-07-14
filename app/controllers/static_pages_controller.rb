class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    # @next_events = Event.order(:date).first(5)
    @next_events = Event.active.order(:date).first(5)

    @just_added = Event.order(:created_at).last(2)
  end
end
