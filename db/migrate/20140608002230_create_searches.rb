class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :summoner_name
      t.integer :max_deaths
      t.integer :max_champions_killed
      t.integer :total_triple_kills
      t.integer :total_double_kills
      t.integer :total_minion_kills
      t.integer :total_minion_kills
      t.integer :most_champion_kills_in_season
      t.integer :damage_taken
      t.integer :damage_dealt
      t.integer :total_champion_kills
      t.integer :total_games_won
      t.integer :total_penta_kills
      t.integer :total_deaths_game
      t.integer :total_gold_earned
      t.integer :total_assits
      t.integer :total_time_spent_dead
      t.integer :total_games_played
      t.integer :total_games_lost
      t.integer :total_first_blood




      t.timestamps
    end
  end
end
