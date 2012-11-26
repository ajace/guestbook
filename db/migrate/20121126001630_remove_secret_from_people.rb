class RemoveSecretFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :secret
  end

  def down
    add_column :people, :secret, :string
  end
end
