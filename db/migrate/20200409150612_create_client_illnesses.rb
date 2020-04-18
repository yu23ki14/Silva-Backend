class CreateClientIllnesses < ActiveRecord::Migration[6.0]
  def change
    create_table :client_illnesses do |t|
      t.references :underlying_illness
      t.references :client
      t.timestamps
    end
  end
end
