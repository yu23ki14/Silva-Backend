class CreateUnderlyingIllnesses < ActiveRecord::Migration[6.0]
  def change
    create_table :underlying_illnesses do |t|
      t.string :name
      t.timestamps
    end
  end
end
