class AddGenderToWords < ActiveRecord::Migration[8.1]
  def change
    add_column :words, :gender, :string
  end
end
