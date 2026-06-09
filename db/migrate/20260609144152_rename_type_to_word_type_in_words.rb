class RenameTypeToWordTypeInWords < ActiveRecord::Migration[8.1]
  def change
    rename_column :words, :type, :word_type
  end
end
