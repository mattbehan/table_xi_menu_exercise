class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    	t.decimal :target_price, presence: true, precision: 20, scale: 2

      t.timestamps null: false
    end
  end
end
