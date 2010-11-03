class CreateNetzkeComponentStates < ActiveRecord::Migration
  def self.up
    create_table :netzke_component_states do |t|
      t.string :component
      t.integer :user_id
      t.integer :role_id
      t.text :value

      t.timestamps
    end
  end

  def self.down
    drop_table :netzke_component_states
  end
end
