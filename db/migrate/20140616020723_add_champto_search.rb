class AddChamptoSearch < ActiveRecord::Migration
  def change
    add_column :searches, :champion, :string
  end
end
