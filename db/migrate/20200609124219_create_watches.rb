class CreateWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :watches do |t|
      t.references :user, foreign_key: true, null: false
      t.references :bbs_thread, foreign_key: true, null: false

      t.timestamps
    end
    add_index :watches, [:user_id, :bbs_thread_id], unique: true
  end
end
