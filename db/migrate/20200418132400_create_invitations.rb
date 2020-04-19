class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.text :uid
      t.references :client
      t.integer :role
      t.text :email
      t.references :user, null: true
      t.integer :from_user_id
      t.timestamps
    end
    add_index :invitations, [:uid], unique: true
  end
end
