class CreateFunFacts < ActiveRecord::Migration[8.1]
  def change
    create_table :fun_facts do |t|
      t.text :fact

      t.timestamps
    end
  end
end
