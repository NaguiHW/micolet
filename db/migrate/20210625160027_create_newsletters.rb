class CreateNewsletters < ActiveRecord::Migration[6.1]
  def change
    create_table :newsletters do |t|
      t.string :email,          null: false
      t.boolean :woman_fashion, default: false
      t.boolean :man_fashion,   default: false
      t.boolean :kid_fashion,   default: false

      t.timestamps
    end
  end
end
