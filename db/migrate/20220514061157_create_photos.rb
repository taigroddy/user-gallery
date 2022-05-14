class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.references :gallery, foreign_key: true, null: false
      t.string :name, index: { unique: true }
      t.datetime :shooting_date
      t.text :short_description
      t.attachment :image, null: false

      t.timestamps
    end
  end
end
