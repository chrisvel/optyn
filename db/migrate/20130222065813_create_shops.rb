class CreateShops < ActiveRecord::Migration
  def change
    rename_table :addresses, :locations 
    create_table :shops do |t|
      t.string :name

      t.timestamps
    end
  end
end
