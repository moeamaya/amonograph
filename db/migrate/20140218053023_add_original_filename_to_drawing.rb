class AddOriginalFilenameToDrawing < ActiveRecord::Migration
  def change
    add_column :drawings, :original_filename, :string
  end
end
