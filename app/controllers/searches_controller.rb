require 'dotenv'
Dotenv.load
require 'unirest'
class SearchesController < ApplicationController
  def create
    @summoner_name = params[:search]
    @search = Search.create(:summoner_name => params[:search])
   


    redirect_to "/searches/#{@search.id}"
  end

  def rank_stats(summoner_name)
    @response = Unirest::get "https://teemojson.p.mashape.com/player/na/#{summoner_name}/ranked_stats/season/4", 
    headers: { 
    "X-Mashape-Authorization" => ENV["LEAGUE_API"]
    }
  end

  def new

  end

  def update_search
    @search = Search.find(params[:search_id])
    @search.champion = params[:champion_name]
    @search.save
    @champion = Champion.find_by(:name => params[:champion_name])
    @name = @champion.name
    @title = @champion.title
    @blurb = @champion.blurb
    @image = @champion.image
    @stats = rank_stats(@search.summoner_name)
    var_name = "@#{params[:champion_name]}"
    @array = self.instance_variable_set(var_name.to_sym, [])
    @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
             @array.push(stat) if stat["championId"] == @champion.key.to_i
    
    end
    respond_to do |format|
      format.html{redirect_to "searches/#{@search.id}"}
      format.js {}
    end
  end


  def ranked_league(summoner_name)
  @response = Unirest::get "https://teemojson.p.mashape.com/player/na/#{summoner_name}/leagues", 
  headers: { 
    "X-Mashape-Authorization" => ENV["LEAGUE_API"]
  }
  end

  def match_history(summoner_name)
    @match = Unirest::get "https://teemojson.p.mashape.com/player/na/#{summoner_name}/recent_games", 
  headers: { 
    "X-Mashape-Authorization" => ENV["LEAGUE_API"]
  }
  end

  def show
    @champions = Champion.all
    @search = Search.find(params[:id])
    @summoner_name = @search.summoner_name
    # @stats = rank_stats(@summoner_name)
     @league = ranked_league(@summoner_name)
     @rank = @league.body["data"]["summonerLeagues"]["array"][0]["tier"]
     @tier = @league.body["data"]["summonerLeagues"]["array"][0]["requestorsRank"]

     @match_history = match_history(@summoner_name)
     @champ_images = []
     @game_stats = []
     @match_history.body["data"]["gameStatistics"]["array"][0..2].each do |match|
        champ = Champion.find_by(:key => match["championId"])
        @champ_images.push(champ.image)
        @game_stats.push(match["statistics"]["array"])
     end


    # @aatrox = []
    # aatrox = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @aatrox.push(stat) if stat["championId"] == 266 
    #           end

    # @ahri = []
    # ahri = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @ahri.push(stat) if stat["championId"] == 103 
    #         end

    # @akali = []
    # akali = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @akali.push(stat) if stat["championId"] == 84 
    #          end

    # @alistar = []
    # alistar = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @alistar.push(stat) if stat["championId"] == 12 
    #            end

    # @amumu = []
    # amumu = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @amumu.push(stat) if stat["championId"] == 32 
    #          end

    # @anivia = []
    # anivia = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @anivia.push(stat) if stat["championId"] == 34 
    #           end

    # @annie = []
    # annie = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @annie.push(stat) if stat["championId"] == 1 
    #           end

    # @ashe = []
    # ashe = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @ashe.push(stat) if stat["championId"] == 22 
    #         end

    # @blitzcrank = []
    # blitzcrank = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #               @blitzcrank.push(stat) if stat["championId"] == 53 
    #               end
    # @brand = []
    # brand = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @brand.push(stat) if stat["championId"] == 63 
    #           end

    # # braum = []
    # # @braum = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    # #          newray.push(stat) if stat["championId"] == 266 
    # #          end

    # @caitlyn = []
    # caitlyn = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @caitlyn.push(stat) if stat["championId"] == 51 
    #           end

    # @cassiopeia = []
    # cassiopeia = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #               @cassiopeia.push(stat) if stat["championId"] == 69 
    #               end

    # @chogath = []
    # chogath = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @chogath.push(stat) if stat["championId"] == 31 
    #            end

    # @corki = []
    # corki =  @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @corki.push(stat) if stat["championId"] == 42 
    #           end

    # @darius = []
    # darius = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @darius.push(stat) if stat["championId"] == 122 
    #           end

    # @diana = []
    # diana = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @diana.push(stat) if stat["championId"] == 131 
    #           end

    # @drmundo = []
    # drmundo = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @drmundo.push(stat) if stat["championId"] == 36 
    #           end

    # @draven = []
    # draven = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @draven.push(stat) if stat["championId"] == 119 
    #           end

    # @elise = []
    # elise = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @elise.push(stat) if stat["championId"] == 60 
    #           end

    # @evelynn = []
    # evelynn = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @evelynn.push(stat) if stat["championId"] == 28 
    #           end

    # @ezreal = []
    # ezreal = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @ezreal.push(stat) if stat["championId"] == 81 
    #           end

    # @fiddlesticks = []
    # fiddlesticks = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #                 @fiddlesticks.push(stat) if stat["championId"] == 9 
    #                 end

    # @fiora = []
    # fiora = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          fiora.push(stat) if stat["championId"] == 114 
    #          end

    # @fizz = []
    # fizz = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @fizz.push(stat) if stat["championId"] == 105 
    #         end


    # @galio = []
    # galio = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @galio.push(stat) if stat["championId"] == 3 
    #          end

    # @gangplank = []
    # gangplank = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #              @gangplank.push(stat) if stat["championId"] == 41 
    #              end

    # @garen = []
    # garen = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @garen.push(stat) if stat["championId"] == 86 
    #          end

    # @gragas = []
    # gragas = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @gragas.push(stat) if stat["championId"] == 79 
    #           end

    # @graves = []
    # graves = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @graves.push(stat) if stat["championId"] == 104 
    #           end

    # @hecarim = []
    # hecarim = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @hecarim.push(stat) if stat["championId"] == 120 
    #            end

    # @heimerdinger = []
    # heimerdinger = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #                 @heimerdinger.push(stat) if stat["championId"] == 74 
    #                 end

    # @irelia = []
    # irelia = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @irelia.push(stat) if stat["championId"] == 39 
    #           end

    # @janna = []
    # janna = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @janna.push(stat) if stat["championId"] == 40 
    #          end

    # @jarvan = []
    # jarvan = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @jarvan.push(stat) if stat["championId"] == 59 
    #           end

    # @jax = []
    # jax = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #        @jax.push(stat) if stat["championId"] == 24 
    #        end

    # @jayce = []
    # jayce = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @jayce.push(stat) if stat["championId"] == 126 
    #          end

    # @jinx = []
    # jinx = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @jinx.push(stat) if stat["championId"] == 222 
    #         end

    # @karma = []
    # karma = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @karma.push(stat) if stat["championId"] == 43 
    #          end

    # @karthus = []
    # karthus = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @karthus.push(stat) if stat["championId"] == 30 
    #          end

    # @kassadin = []
    # kassadin = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @kassadin.push(stat) if stat["championId"] == 38 
    #             end

    # @katarina = []
    # katarina = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @katarina.push(stat) if stat["championId"] == 55 
    #             end
    # @kayle = []
    # kayle = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @kayle.push(stat) if stat["championId"] == 10 
    #          end
    # @kennen = []
    # kennen = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @kennen.push(stat) if stat["championId"] == 85 
    #           end
    # @khazix = []
    # khazix = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @khazix.push(stat) if stat["championId"] == 121 
    #           end
    # @kogmaw = []
    # kogmaw = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @kogmaw.push(stat) if stat["championId"] == 96 
    #           end
    # @leblanc = []
    # leblanc = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @leblanc.push(stat) if stat["championId"] == 7 
    #            end
    # @leesin = []
    # leesin = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @leesin.push(stat) if stat["championId"] == 64 
    #           end
    # @leona = []
    # leona = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @leona.push(stat) if stat["championId"] == 89 
    #          end
    # @lissandra = []
    # lissandra = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #              @lissandra.push(stat) if stat["championId"] == 127
    #              end
    # @lucian = []
    # lucian = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @lucian.push(stat) if stat["championId"] == 236 
    #           end
    # @lulu = []
    # lulu = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @lulu.push(stat) if stat["championId"] == 117 
    #         end
    # @lux = []
    # lux = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #        @lux.push(stat) if stat["championId"] == 99 
    #        end
    # @malphite = []
    # malphite = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @malphite.push(stat) if stat["championId"] == 54 
    #             end
    # @malzahar = []
    # malzahar = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @malzahar.push(stat) if stat["championId"] == 90 
    #             end
    # @maokai = []
    # maokai = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @maokai.push(stat) if stat["championId"] == 57 
    #           end

    # @masteryi = []
    # masteryi = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @masteryi.push(stat) if stat["championId"] == 11 
    #             end
    # @missfortune = []
    # missfortune = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #                @missfortune.push(stat) if stat["championId"] == 21 
    #                end

    # @mordekaiser = []
    # mordekaiser = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #                @mordekaiser.push(stat) if stat["championId"] == 82 
    #                end
    # @morgana = []
    # morgana = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @morgana.push(stat) if stat["championId"] == 25 
    #            end
    # @nami= []
    # nami = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @nami.push(stat) if stat["championId"] == 267 
    #         end

    # @nasus = []
    # nasus = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @nasus.push(stat) if stat["championId"] == 75 
    #          end
    # @nautilus = []
    # nautilus = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @nautilus.push(stat) if stat["championId"] == 111 
    #             end
    # @nidalee = []
    # nidalee = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @nidalee.push(stat) if stat["championId"] == 76 
    #            end
    # @nocturne = []
    # nocturne = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @nocturne.push(stat) if stat["championId"] == 56 
    #             end
    # @nunu = []
    # nunu = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @nunu.push(stat) if stat["championId"] == 20 
    #         end
    # @olaf = []
    # olaf = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @olaf.push(stat) if stat["championId"] == 2 
    #         end
    # @orianna = []
    # orianna = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @orianna.push(stat) if stat["championId"] == 61 
    #            end
    # @pantheon = []
    # pantheon = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @pantheon.push(stat) if stat["championId"] == 80 
    #             end
    # @poppy = []
    # poppy = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @poppy.push(stat) if stat["championId"] == 78 
    #          end
    # @quinn = []
    # quinn = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @quinn.push(stat) if stat["championId"] == 133 
    #          end
    # @rammus = []
    # rammus = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @rammus.push(stat) if stat["championId"] == 33 
    #           end
    # @renekton = []
    # renekton = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @renekton.push(stat) if stat["championId"] == 58 
    #             end
    # @rengar = []
    # rengar = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @rengar.push(stat) if stat["championId"] == 107 
    #           end
    # @riven = []
    # riven = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @riven.push(stat) if stat["championId"] == 92 
    #          end
    # @rumble = []
    # rumble = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @rumble.push(stat) if stat["championId"] == 68 
    #           end
    # @ryze = []
    # ryze = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @ryze.push(stat) if stat["championId"] == 13 
    #         end
    # @sejuani = []
    # sejuani = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @sejuani.push(stat) if stat["championId"] == 113 
    #            end
    # @shaco = []
    # shaco = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @shaco.push(stat) if stat["championId"] == 35 
    #           end
    # @shen = []
    # shen = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @shen.push(stat) if stat["championId"] == 98 
    #         end
    # @shyvana = []
    # shyvana = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @shyvana.push(stat) if stat["championId"] == 102 
    #            end
    # @singed = []
    # singed = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @singed.push(stat) if stat["championId"] == 27 
    #           end
    # @sion = []
    # sion = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @sion.push(stat) if stat["championId"] == 14 
    #         end
    # @sivir = []
    # sivir = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @sivir.push(stat) if stat["championId"] == 15 
    #          end
    # @skarner = []
    # skarner = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @skarner.push(stat) if stat["championId"] == 72 
    #            end
    # @sona = []
    # sona = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @sona.push(stat) if stat["championId"] == 37 
    #         end
    # @soraka = []
    # soraka = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @soraka.push(stat) if stat["championId"] == 16 
    #           end
    # @swain = []
    # swain = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @swain.push(stat) if stat["championId"] == 50 
    #          end
    # @syndra = []
    # syndra = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @syndra.push(stat) if stat["championId"] == 134 
    #           end
    # @talon = []
    # talon = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @talon.push(stat) if stat["championId"] == 91 
    #          end
    # @taric = []
    # taric = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @taric.push(stat) if stat["championId"] == 44 
    #          end
    # @teemo = []
    # teemo = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @teemo.push(stat) if stat["championId"] == 17 
    #          end
    # @thresh = []
    # thresh = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @thresh.push(stat) if stat["championId"] == 412 
    #           end
    # @tristana = []
    # tristana = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @tristana.push(stat) if stat["championId"] == 18 
    #             end
    # @trundle = []
    # trundle = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @trundle.push(stat) if stat["championId"] == 48 
    #            end
    # @tryndamere = []
    # tryndamere = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #               @tryndamere.push(stat) if stat["championId"] == 23 
    #               end
    # @twisted_fate = []
    # twistedfate = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #                @twisted_fate.push(stat) if stat["championId"] == 4 
    #                end
    # @twitch = []
    # twitch = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @twitch.push(stat) if stat["championId"] == 29 
    #           end
    # @udyr = []
    # udyr = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @udyr.push(stat) if stat["championId"] == 77 
    #         end
    # @urgot = []
    # urgot = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @urgot.push(stat) if stat["championId"] == 6 
    #          end
    # @varus = []
    # varus = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @varus.push(stat) if stat["championId"] == 110 
    #          end
    # @vayne = []
    # vayne = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @vayne.push(stat) if stat["championId"] == 67 
    #          end
    # @veigar = []
    # veigar = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @veigar.push(stat) if stat["championId"] == 45 
    #           end
    # # velkoz = []
    # # @velkoz = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    # #           velkoz.push(stat) if stat["championId"] == 85 
    # #           end
    # @vi = []
    # vi = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #       @vi.push(stat) if stat["championId"] == 254 
    #       end
    # @viktor = []
    # viktor = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @viktor.push(stat) if stat["championId"] == 112 
    #           end
    # @vladimir = []
    # vladimir = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @vladimir.push(stat) if stat["championId"] == 8 
    #             end
    # @volibear = []
    # volibear = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #             @volibear.push(stat) if stat["championId"] == 106 
    #             end
    # @warwick = []
    # warwick = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @warwick.push(stat) if stat["championId"] == 19 
    #            end
    # @wukong = []
    # wukong = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @wukong.push(stat) if stat["championId"] == 62 
    #           end
    # @xerath = []
    # xerath = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @xerath.push(stat) if stat["championId"] == 101 
    #           end
    # @xin_zhao = []
    # xinzhao = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #            @xin_zhao.push(stat) if stat["championId"] == 5 
    #            end
    # @yasuo = []
    # yasuo = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @yasuo.push(stat) if stat["championId"] == 157 
    #          end
    # @yorick = []
    # yorick = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @yorick.push(stat) if stat["championId"] == 83 
    #           end
    # @zak = []
    # zak = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #        @zak.push(stat) if stat["championId"] == 154 
    #        end
    # @zed = []
    # zed = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #        @zed.push(stat) if stat["championId"] == 238 
    #        end
    # @ziggs = []
    # ziggs = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #          @ziggs.push(stat) if stat["championId"] == 115 
    #          end
    # @zilean = []
    # zilean = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #           @zilean.push(stat) if stat["championId"] == 26 
    #           end
    # @zyra = []
    # zyra = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
    #         @zyra.push(stat) if stat["championId"] == 143 
    #         end

  end

end
