class AddIndexToItemsPending < ActiveRecord::Migration
  def change
    add_index :items, :pending
  end
end
