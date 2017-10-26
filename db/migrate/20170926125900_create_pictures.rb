class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.references :real_estate, foreign_key: true
      t.timestamps
    end
  end
end
