class AddPositionToTemplates < ActiveRecord::Migration
  def change
    add_column(:templates, :position, :integer)
  end
end
