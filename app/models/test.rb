require 'dotenv'
Dotenv.load
require 'unirest'

def champion
@response = Unirest::get "https://teemojson.p.mashape.com/datadragon/champion", 
  headers: { 
    "X-Mashape-Authorization" => ENV["LEAGUE_API"]
  }
end

