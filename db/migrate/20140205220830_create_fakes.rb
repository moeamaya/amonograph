class CreateFakes < ActiveRecord::Migration
  def change
    create_table :fakes do |t|
      t.string :title

      t.timestamps
    end
  end
end
