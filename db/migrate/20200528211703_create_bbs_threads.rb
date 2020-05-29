class CreateBbsThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :bbs_threads do |t|
      t.integer :user_id
      t.string :title
      t.string :content

      t.timestamps
      
      t.index :user_id
    end
  end
end
