class AddPropertyToMenu < ActiveRecord::Migration
  def change
  	add_column :menus, :menu_items, :hstore, presence: true
  end
end
