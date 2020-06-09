class CreateUserPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_posts do |t|
      t.references :bbs_thread, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :content
      t.integer :post_number, null: false

      t.timestamps
      
    end
  end
end
