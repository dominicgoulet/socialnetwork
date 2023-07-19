class CreateAudiences < ActiveRecord::Migration[7.0]
  def change
    create_table :audiences, id: :uuid do |t|
      t.references :activity, null: false, foreign_key: true, type: :uuid
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.string :privacy

      t.timestamps
    end
  end
end
