class CreateAnonymousPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :anonymous_posts do |t|
      t.string :name
      t.text :content
      t.string :password_digest
      t.references :bbs_thread, foreign_key: true, null: false
      t.integer :post_number, null: false

      t.timestamps
    end
  end
end
