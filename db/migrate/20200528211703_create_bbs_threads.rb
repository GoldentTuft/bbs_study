class CreateBbsThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :bbs_threads do |t|
      t.integer :user_id
      t.string :title
      t.string :content
      t.integer :total_posted, null: false, default: 0

      t.timestamps
      
    end
  end
end
