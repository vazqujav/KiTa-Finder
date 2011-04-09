class CreateKitas < ActiveRecord::Migration
  def self.up
    create_table :kitas do |t|
      t.string :name
      t.string :contact
      t.string :street
      t.string :zip
      t.string :city
      t.string :country_code
      t.string :geocoded_address
      t.string :phone
      t.string :url
      t.text :details
      t.string :age_from
      t.string :age_to
      t.boolean :is_active
      t.boolean :is_geocoded
      t.string :data_origin
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :kitas
  end
end
