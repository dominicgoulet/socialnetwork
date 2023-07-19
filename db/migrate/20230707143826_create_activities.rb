class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities, id: :uuid do |t|
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.references :object, null: false, polymorphic: true, type: :uuid
      t.string :verb

      t.timestamps
    end
  end
end
