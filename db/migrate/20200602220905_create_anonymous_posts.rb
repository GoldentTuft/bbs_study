class CreateAnonymousPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :anonymous_posts do |t|
      t.string :name
      t.text :content
      t.string :password_digest
      t.references :bbs_thread, foreign_key: true

      t.timestamps
    end
  end
end
