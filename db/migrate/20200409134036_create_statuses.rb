class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.text :text
      t.references :user
      t.references :client
      t.timestamps
    end
  end
end
