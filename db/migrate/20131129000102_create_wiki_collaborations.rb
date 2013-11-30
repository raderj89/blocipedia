class CreateWikiCollaborations < ActiveRecord::Migration
  def change
    create_table :wiki_collaborations do |t|
      t.integer :wiki_id
      t.integer :user_id

      t.timestamps
    end
    add_index :wiki_collaborations, [:wiki_id, :user_id]
  end
end
