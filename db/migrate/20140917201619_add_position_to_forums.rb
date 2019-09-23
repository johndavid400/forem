class AddPositionToForums < ActiveRecord::Migration[4.2]
  def change
    add_column :forem_forums, :position, :integer, :default => 0
  end
end
