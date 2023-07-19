class CreateCircles < ActiveRecord::Migration[7.0]
  def change
    create_table :circles, id: :uuid do |t|
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.string :display_name

      t.timestamps
    end
  end
end
