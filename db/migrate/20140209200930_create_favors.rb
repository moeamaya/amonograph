class CreateFavors < ActiveRecord::Migration
  def change
    create_table :favors do |t|
      t.references :user, index: true
      t.references :drawing, index: true

      t.timestamps
    end
  end
end
