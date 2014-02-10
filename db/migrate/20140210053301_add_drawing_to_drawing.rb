class AddDrawingToDrawing < ActiveRecord::Migration
  def change
    add_column :drawings, :drawing, :string
  end
end
