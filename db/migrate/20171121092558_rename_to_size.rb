class RenameToSize < ActiveRecord::Migration[5.1]
  def change
    rename_column :real_estates, :squared_meters, :size
  end
end
