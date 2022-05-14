class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, index: { unique: true }, null: false
      t.text :short_description, null: false

      t.timestamps
    end
  end
end
