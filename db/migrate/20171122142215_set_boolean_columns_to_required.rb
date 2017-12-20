class SetBooleanColumnsToRequired < ActiveRecord::Migration[5.1]
  def change
    change_column_null :real_estates, :balcony, :boolean, default: 'f'
    change_column_null :real_estates, :renovated, :boolean, default: 'f'
    change_column_null :real_estates, :elevator, :boolean, default: 'f'
    change_column_null :real_estates, :old_building, :boolean, default: 'f'
    change_column_null :real_estates, :sold, :boolean, default: 'f'
  end
end
