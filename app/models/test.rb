require 'unirest'

def champion
@response = Unirest::get "https://teemojson.p.mashape.com/datadragon/champion", 
  headers: { 
    "X-Mashape-Authorization" => "XMxE0oKP0YqjU4fVpZIC4t2kaDUrhoAx"
  }
end

