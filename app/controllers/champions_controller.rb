require 'unirest'
class ChampionsController < ApplicationController


  def create
    @response = Unirest::get "https://teemojson.p.mashape.com/datadragon/champion", 
  headers: { 
    "X-Mashape-Authorization" => "XMxE0oKP0YqjU4fVpZIC4t2kaDUrhoAx"
  }

   @response.body["data"].each do |x,y|
      if y["name"]["'"] != nil
         y["name"].delete!("'")
      elsif  y["name"][" "] != nil
         y["name"].delete!(" ")
      elsif y["name"] == "Wukong"
         y["name"] = "MonkeyKing"
      end
    Champion.create(:name => y["name"], :key => y["key"], :title => y["title"], :blurb => y["blurb"], :image => "http://ddragon.leagueoflegends.com/cdn/4.9.1/img/champion/#{y['name']}.png")
    end
    redirect_to "/"
  end

  def index
    @champions = Champion.all
  end
end
