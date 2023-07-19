class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people, id: :uuid do |t|
      t.string :display_name
      t.string :slug

      t.timestamps
    end
  end
end
