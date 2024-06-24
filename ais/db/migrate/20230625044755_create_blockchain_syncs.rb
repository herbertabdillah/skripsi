class CreateBlockchainSyncs < ActiveRecord::Migration[6.1]
  def change
    create_table :blockchain_syncs do |t|
      t.string :syncable_type
      t.integer :syncable_id
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
