class AddNewColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :likes, :integer
    change_column :projects, :images, "varchar[] USING (string_to_array(images, ','))"
  end
end
