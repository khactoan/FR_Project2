class CreateAdminPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_posts do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
