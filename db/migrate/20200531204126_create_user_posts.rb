class CreateUserPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_posts do |t|
      t.references :bbs_thread, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
      
    end
  end
end
