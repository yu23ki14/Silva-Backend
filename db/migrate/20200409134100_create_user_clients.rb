class CreateUserClients < ActiveRecord::Migration[6.0]
  def change
    create_table :user_clients do |t|
      t.references :user
      t.references :client
      t.integer :role
      t.timestamps
    end
  end
end
