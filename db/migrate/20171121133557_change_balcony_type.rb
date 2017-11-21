class ChangeBalconyType < ActiveRecord::Migration[5.1]
  def change
    change_column :real_estates, :balcony, :boolean
  end
end
