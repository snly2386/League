require 'unirest'
class SearchesController < ApplicationController
  def create
    @summoner_name = params[:search]
    @stats = rank_stats(@summoner_name)
    @search = Search.create(:summoner_name => params[:search])
    aatrox = []
    @aatrox = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
              newray.push(stat) if stat["championId"] == 266 
              end

    ahri = []
    @ahri = @stats.body["data"]["lifetimeStatistics"]["array"].each do |stat| 
            newray.push(stat) if stat["championId"] == 103 
            end
    akali = []
    alistar = []
    amumu = []
    anivia = []
    annie = []
    ashe = []
    blitzcrank = []
    brand = []
    braum = []
    caitlyn = []
    cassiopeia = []
    chogath = []
    corki = []
    darius = []
    diana = []
    drmundo = []
    draven = []
    elise = []
    evelynn = []
    ezreal = []
    fiddlesticks = []
    fiora = []
    fizz = []
    galio = []
    gangplank = []
    garen = []
    gragas = []
    graves = []
    hecarim = []
    heimerdinger = []
    irelia = []
    janna = []
    jarvan = []
    jax = []
    jayce = []
    jinx = []
    karma = []
    karthus = []
    kassadin = []
    katarina = []
    kayle = []
    kennen = []
    khazix = []
    kogmaw = []
    leblanc = []
    leesin = []
    leona = []
    lissandra = []
    lucian = []
    lulu = []
    lux = []
    malphite = []
    malzahar = []
    maokai = []
    masteryi = []
    missfortune = []
    mordekaiser = []
    morgana = []
    nami= []
    nasus = []
    nautilus = []
    nidalee = []
    nocturne = []
    nunu = []
    olaf = []
    orianna = []
    pantheon = []
    poppy = []
    quinn = []
    rammus = []
    rengar = []
    riven = []
    rumble = []
    ryze = []
    sejuani = []
    shaco = []
    shen = []
    shyvana = []
    singed = []
    sion = []
    sivir = []
    skarner = []
    sona = []
    soraka = []
    swain = []
    syndra = []
    talon = []
    taric = []
    teemo = []
    thresh = []
    tristana = []
    trundle = []
    tryndamere = []
    twisted fate = []
    twitch = []
    udyr = []
    urgot = []
    varus = []
    vayne = []
    veigar = []
    velkoz = []
    vi = []
    viktor = []
    vladimir = []
    volibear = []
    warwick = []
    wukong = []
    xerath = []
    xin zhao = []
    yasuo = []
    yorick = []
    zak = []
    zed = []
    ziggs = []
    zilean = []
    zyra = []


    redirect_to "/searches/#{@search.id}"
  end

  def rank_stats(summoner_name)
    @response = Unirest::get "https://teemojson.p.mashape.com/player/na/#{summoner_name}/ranked_stats/season/4", 
    headers: { 
    "X-Mashape-Authorization" => "XMxE0oKP0YqjU4fVpZIC4t2kaDUrhoAx"
    }
  end

  def new

  end

  def show
    @search = Search.find(params[:id])
  end

end
