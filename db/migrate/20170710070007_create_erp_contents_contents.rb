class CreateErpContentsContents < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contents_contents do |t|
      t.string :name
      t.text :content
      t.string :position
      t.boolean :archived, default: false      
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
