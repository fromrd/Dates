class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :content
      t.text :image
      t.integer :sample_flag
      t.timestamps
    end
  end
end
