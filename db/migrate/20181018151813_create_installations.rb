class CreateInstallations < ActiveRecord::Migration[5.2]
  def change
    create_table :installations do |t|
      t.integer :external_id
      t.string :access_token

      t.timestamps
    end
  end
end
