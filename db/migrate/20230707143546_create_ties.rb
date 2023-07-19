class CreateTies < ActiveRecord::Migration[7.0]
  def change
    create_table :ties, id: :uuid do |t|
      t.references :circle, null: false, foreign_key: true, type: :uuid
      t.references :actor, null: false, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
