class CreateSchema < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title,            null: false
      t.text :description
      t.integer :reviews_count,   default: 0
      t.decimal :reviews_average, default: 0, precision: 4, scale: 2
    end

    create_table :reviews do |t|
      t.integer :show_id,         null: false
      t.string :critic_name,      null: false
      t.string :publication_name
      t.float :score,             null: false
      t.text :body
    end

    add_index :reviews, :show_id
  end
end
