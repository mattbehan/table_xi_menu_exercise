class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    	t.integer :target_price, presence: true

      t.timestamps null: false
    end
  end
end
