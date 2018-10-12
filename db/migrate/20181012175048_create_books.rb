class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :url
      t.string :image
      t.float :avg_rating
      t.bigint :num_rating
      t.integer :published

      t.timestamps
    end
  end
end
