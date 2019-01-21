class CreateGarage < ActiveRecord::Migration[5.2]
  def change
    create_table :garages do |t|
      t.string :name, null: false
    end
  end
end
