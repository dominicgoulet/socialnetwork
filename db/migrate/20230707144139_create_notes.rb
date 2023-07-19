class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end
end
