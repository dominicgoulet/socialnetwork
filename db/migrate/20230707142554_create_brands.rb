class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands, id: :uuid do |t|
      t.string :display_name
      t.string :slug
      t.string :website

      t.timestamps
    end
  end
end
