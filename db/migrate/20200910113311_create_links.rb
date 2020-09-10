class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :full_name
      t.string :short_name
      t.integer :quantity_visit, default: 0
      t.string :password

      t.timestamps
    end
  end
end
