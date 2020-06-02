class CreateUserPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_posts do |t|
      t.integer :bbs_thread_id
      t.integer :user_id
      t.string :content

      t.timestamps
      
    end
  end
end
