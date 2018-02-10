class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
    	t.text :original_url
    	t.text :short_url
    	t.string :sanitize_url
    	t.integer :user_id
      t.timestamps
    end
  end
end
