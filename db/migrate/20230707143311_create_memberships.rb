class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :group, null: false, foreign_key: true, type: :uuid
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.string :level

      t.timestamps
    end
  end
end
