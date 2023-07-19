class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :display_name
      t.string :privacy

      t.timestamps
    end
  end
end
