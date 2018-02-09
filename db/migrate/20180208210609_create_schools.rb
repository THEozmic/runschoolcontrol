class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.text :name
      t.text :username
      t.text :password_digest

      t.timestamps
    end
    add_index :schools, :username, unique: true
    add_index :schools, :name, unique: true
  end
end
