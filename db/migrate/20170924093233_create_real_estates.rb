class CreateRealEstates < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estates do |t|
      t.text :description
      t.decimal :price
      t.decimal :lat
      t.decimal :lon
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
