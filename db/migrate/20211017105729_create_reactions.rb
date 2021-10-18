class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reactable, polymorphic: true, null: false
      t.string :reaction_type, null: false

      t.index [:user_id, :reactable_id, :reactable_type, :reaction_type],
        unique: true, name: 'index_on_reactions_user_reactable_type_reaction_type'

      t.timestamps
    end
  end
end
