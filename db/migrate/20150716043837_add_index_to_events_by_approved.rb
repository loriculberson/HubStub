class AddIndexToEventsByApproved < ActiveRecord::Migration
  def change
    add_index :events, :approved
  end
end
