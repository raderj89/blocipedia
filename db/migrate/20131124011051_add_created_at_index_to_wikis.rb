class AddCreatedAtIndexToWikis < ActiveRecord::Migration
  def change
    add_index :wikis, :created_at
  end
end
