class AddNoKitaVotesToKita < ActiveRecord::Migration
  def self.up
    add_column :kitas, :no_kita_votes, :integer, { :default => 0 }
  end

  def self.down
    remove_column :kitas, :no_kita_votes
  end
end
