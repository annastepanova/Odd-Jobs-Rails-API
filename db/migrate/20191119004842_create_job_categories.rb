class CreateJobCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :job_categories do |t|
      t.string :name
      t.string :image_url
      t.timestamps
    end
  end
end
