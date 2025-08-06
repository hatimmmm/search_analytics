class CreateSearches < ActiveRecord::Migration[8.0]
  def change
    create_table :searches do |t|
      t.string :query
      t.string :ip_address

      t.timestamps
    end
    add_index :searches, :ip_address
    add_index :searches, [:ip_address, :created_at]
  end
end
