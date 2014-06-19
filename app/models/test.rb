require 'dotenv'
Dotenv.load
require 'unirest'

def champion
@response = Unirest::get "https://teemojson.p.mashape.com/datadragon/champion", 
  headers: { 
    "X-Mashape-Authorization" => ENV["LEAGUE_API"]
  }
end

def match_history
@match = Unirest::get "https://teemojson.p.mashape.com/player/na/ballsakitysak/recent_games", 
  headers: { 
    "X-Mashape-Authorization" => "XMxE0oKP0YqjU4fVpZIC4t2kaDUrhoAx"
  }
end

