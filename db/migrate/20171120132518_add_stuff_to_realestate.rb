class AddStuffToRealestate < ActiveRecord::Migration[5.1]
  def change
    add_column :real_estates, :floor, :integer
    add_column :real_estates, :squared_meters, :float
    add_column :real_estates, :room_number, :float
    add_column :real_estates, :balcony, :string
    add_column :real_estates, :renovated, :boolean
    add_column :real_estates, :elevator, :boolean
    add_column :real_estates, :old_building, :boolean
    add_column :real_estates, :sold, :boolean
  end
end
