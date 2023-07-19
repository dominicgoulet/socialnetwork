class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :actor, null: false, polymorphic: true, type: :uuid
      t.references :activity, null: false, foreign_key: true, type: :uuid
      t.datetime :read_at

      t.timestamps
    end
  end
end
