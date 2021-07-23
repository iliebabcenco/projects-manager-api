class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :name, :content
  end
end
