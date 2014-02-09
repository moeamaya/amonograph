class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :drawing, index: true

      t.timestamps
    end
  end
end
