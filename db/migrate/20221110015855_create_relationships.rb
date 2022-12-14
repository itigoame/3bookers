class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.index [:follower_id, :followed_id], unique: true

      t.timestamps
    end
  end
end
