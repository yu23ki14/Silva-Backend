class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :initial
      t.integer :gender
      t.integer :age
      t.string :address
      t.integer :grade
      t.timestamps
    end
  end
end
