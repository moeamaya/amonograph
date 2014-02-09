class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.string :title
      t.text :about
      t.integer :views
      t.references :user, index: true

      t.timestamps
    end
  end
end
