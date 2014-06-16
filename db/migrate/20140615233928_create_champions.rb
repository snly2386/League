class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string :name
      t.string :key
      t.string :title
      t.text   :blurb
      t.string :image
      

      t.timestamps
    end
  end
end
