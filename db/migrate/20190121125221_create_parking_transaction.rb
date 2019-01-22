class CreateParkingTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :parking_transactions do |t|
      t.belongs_to :floor
      t.boolean :active, null: false, default: true
      t.string :ticket, null: false
    end

    # optimize a) checking if ticket exists during validations
    # b) ticket lookup for check out process
    add_index :parking_transactions, [:active, :ticket], unique: true
  end
end
