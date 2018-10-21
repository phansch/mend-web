class AddUserIdToInstallations < ActiveRecord::Migration[5.2]
  def change
    add_reference :installations, :user, foreign_key: true, index: true
  end
end
