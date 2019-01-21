class CreateFloors < ActiveRecord::Migration[5.2]
  def change
    create_table :floors do |t|
      t.integer :number_of_spaces, null:false
      t.belongs_to :garage
    end
  end
end
