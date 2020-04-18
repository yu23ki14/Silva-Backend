class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.text :text
      t.references :user
      t.references :client
      t.integer :role
      t.timestamps
    end
  end
end
