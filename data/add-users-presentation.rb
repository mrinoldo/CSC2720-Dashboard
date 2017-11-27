require 'mongo'                                 # used to connect to our mongodb database
require 'dotenv'                                # used to load environment variable for database credentials

Dotenv.load                                     # load environment variable that contains credentials to 
                                                # connect to database
Mongo::Logger.logger.level = ::Logger::FATAL
client = Mongo::Client.new(ENV['MONGOLAB_URI']) # connect to database
collection = client[:users]

# hard code an array of 200 documents to add to database one by one during presentation
# all prior data was added much more efficiently using mongoimport and CSV files

docs = [  {username:'cpinckney0', os:'iOS',region:'South America',date:1511968064},
  {username:'ggowar1', os:'Android',region:'Africa',date:1511893689},
  {username:'jghione2', os:'iOS',region:'North America',date:1511955227},
  {username:'amaddra3', os:'iOS',region:'Asia',date:1511861413},
  {username:'cheaker4', os:'Android',region:'Asia',date:1511997511},
  {username:'cpoxton5', os:'iOS',region:'Asia',date:1511880225},
  {username:'lbrookhouse6', os:'iOS',region:'Europe',date:1511942429},
  {username:'ngoodee7', os:'Android',region:'South America',date:1511867081},
  {username:'acressingham8', os:'iOS',region:'Africa',date:1511829332},
  {username:'znanni9', os:'Android',region:'North America',date:1511871507},
  {username:'bverneya', os:'iOS',region:'South America',date:1511925371},
  {username:'sjoriozb', os:'Android',region:'North America',date:1511880140},
  {username:'lpingstonec', os:'iOS',region:'North America',date:1511974460},
  {username:'dmcevillyd', os:'Android',region:'Africa',date:1511853294},
  {username:'glutoe', os:'Android',region:'Oceania',date:1511936647},
  {username:'khayballf', os:'iOS',region:'North America',date:1511946608},
  {username:'sbunneyg', os:'Android',region:'Oceania',date:1511992915},
  {username:'hbuckleeh', os:'Android',region:'Oceania',date:1511856603},
  {username:'adurrani', os:'iOS',region:'Asia',date:1511876119},
  {username:'ndreusj', os:'Android',region:'Asia',date:1511888411},
  {username:'povidk', os:'Android',region:'South America',date:1511857392},
  {username:'bbraghinil', os:'iOS',region:'South America',date:1511841100},
  {username:'jcecchim', os:'iOS',region:'North America',date:1511836767},
  {username:'lcomettoin', os:'Android',region:'Oceania',date:1511988034},
  {username:'orattenburyo', os:'iOS',region:'South America',date:1511875520},
  {username:'mbenduhnp', os:'Android',region:'Oceania',date:1511909212},
  {username:'wgeharkeq', os:'Android',region:'Asia',date:1511965911},
  {username:'nblantr', os:'Android',region:'North America',date:1511889651},
  {username:'nbentons', os:'iOS',region:'Oceania',date:1511919659},
  {username:'rmaxwalet', os:'Android',region:'South America',date:1511856719},
  {username:'gdottridgeu', os:'iOS',region:'Europe',date:1511974855},
  {username:'astallionv', os:'Android',region:'Oceania',date:1511949255},
  {username:'hjoslinw', os:'Android',region:'Europe',date:1511898337},
  {username:'bfaivrex', os:'iOS',region:'North America',date:1511908518},
  {username:'mjeryy', os:'Android',region:'South America',date:1511948716},
  {username:'dcenterz', os:'iOS',region:'South America',date:1511926650},
  {username:'kwoodger10', os:'iOS',region:'South America',date:1511893017},
  {username:'wwaycott11', os:'iOS',region:'Oceania',date:1511896249},
  {username:'cshapiro12', os:'Android',region:'Africa',date:1511834852},
  {username:'teadmeads13', os:'Android',region:'Europe',date:1511949393},
  {username:'bredding14', os:'Android',region:'Africa',date:1511969699},
  {username:'amackerel15', os:'iOS',region:'Asia',date:1511910205},
  {username:'mkearford16', os:'Android',region:'Europe',date:1511949337},
  {username:'fboutcher17', os:'iOS',region:'Oceania',date:1511952928},
  {username:'hdeare18', os:'Android',region:'Africa',date:1511920486},
  {username:'sraven19', os:'Android',region:'North America',date:1511883700},
  {username:'jousbie1a', os:'Android',region:'Asia',date:1511912576},
  {username:'hservis1b', os:'Android',region:'Oceania',date:1511880390},
  {username:'gmulhall1c', os:'Android',region:'Africa',date:1511916892},
  {username:'tpirelli1d', os:'iOS',region:'Europe',date:1511953257},
  {username:'mhast1e', os:'iOS',region:'Oceania',date:1511968600},
  {username:'cdymocke1f', os:'Android',region:'Oceania',date:1511960961},
  {username:'bmuehle1g', os:'iOS',region:'Europe',date:1511867597},
  {username:'fsimmank1h', os:'Android',region:'North America',date:1511838199},
  {username:'darias1i', os:'iOS',region:'North America',date:1511955069},
  {username:'fmussett1j', os:'iOS',region:'Asia',date:1511958918},
  {username:'oranger1k', os:'Android',region:'Africa',date:1511947114},
  {username:'mfould1l', os:'Android',region:'North America',date:1511920738},
  {username:'kkaemena1m', os:'Android',region:'North America',date:1511891004},
  {username:'edemicoli1n', os:'Android',region:'North America',date:1511913167},
  {username:'aiacomelli1o', os:'iOS',region:'South America',date:1511920183},
  {username:'sluckes1p', os:'iOS',region:'North America',date:1511879346},
  {username:'sgotch1q', os:'Android',region:'Oceania',date:1511875483},
  {username:'alesurf1r', os:'iOS',region:'Oceania',date:1511979082},
  {username:'dskillings1s', os:'iOS',region:'Asia',date:1511946521},
  {username:'gemtage1t', os:'iOS',region:'South America',date:1511923231},
  {username:'vshanks1u', os:'Android',region:'North America',date:1511877583},
  {username:'bgiacobini1v', os:'iOS',region:'South America',date:1511960693},
  {username:'mharrison1w', os:'iOS',region:'Asia',date:1511869774},
  {username:'ndusting1x', os:'iOS',region:'South America',date:1511833893},
  {username:'dvardey1y', os:'iOS',region:'Africa',date:1511939135},
  {username:'ihardison1z', os:'Android',region:'South America',date:1511973227},
  {username:'nhuriche20', os:'Android',region:'Asia',date:1511982472},
  {username:'jtommis21', os:'Android',region:'Oceania',date:1511862985},
  {username:'mcutmore22', os:'Android',region:'Oceania',date:1511838343},
  {username:'gdickenson23', os:'Android',region:'Africa',date:1511880775},
  {username:'aquickfall24', os:'iOS',region:'Asia',date:1511852967},
  {username:'lantyshev25', os:'iOS',region:'Europe',date:1511974116},
  {username:'ncardero26', os:'Android',region:'Oceania',date:1511982663},
  {username:'sbendare27', os:'Android',region:'Africa',date:1511975536},
  {username:'acusack28', os:'Android',region:'South America',date:1511853641},
  {username:'ecampbelldunlop29', os:'Android',region:'Asia',date:1511846494},
  {username:'ssalmons2a', os:'iOS',region:'North America',date:1511958366},
  {username:'sdinley2b', os:'Android',region:'South America',date:1511883779},
  {username:'sruss2c', os:'iOS',region:'Oceania',date:1511832055},
  {username:'relesander2d', os:'iOS',region:'Africa',date:1511829187},
  {username:'cbriand2e', os:'Android',region:'Africa',date:1511968815},
  {username:'lzorzin2f', os:'Android',region:'North America',date:1511866064},
  {username:'wportman2g', os:'Android',region:'Europe',date:1511925322},
  {username:'gguiduzzi2h', os:'iOS',region:'Oceania',date:1511934892},
  {username:'rpoynzer2i', os:'iOS',region:'Europe',date:1511990107},
  {username:'rcribbins2j', os:'Android',region:'Oceania',date:1511971936},
  {username:'ccolson2k', os:'Android',region:'North America',date:1511899640},
  {username:'clabin2l', os:'iOS',region:'Europe',date:1511878438},
  {username:'tandriveaux2m', os:'iOS',region:'South America',date:1511885082},
  {username:'epowderham2n', os:'iOS',region:'North America',date:1511980231},
  {username:'eenglish2o', os:'iOS',region:'Europe',date:1511922611},
  {username:'rweld2p', os:'iOS',region:'Europe',date:1511989634},
  {username:'espriggen2q', os:'iOS',region:'Africa',date:1511866274},
  {username:'wlammerich2r', os:'iOS',region:'Oceania',date:1511882045},
  {username:'bskettles2s', os:'Android',region:'North America',date:1511912207},
  {username:'rbrigdale2t', os:'iOS',region:'North America',date:1511828729},
  {username:'dgerrelts2u', os:'iOS',region:'Europe',date:1511911554},
  {username:'jmaulkin2v', os:'Android',region:'Europe',date:1511914829},
  {username:'ldorkens2w', os:'Android',region:'Asia',date:1511906634},
  {username:'jkarolyi2x', os:'iOS',region:'Africa',date:1511832319},
  {username:'bwehner2y', os:'Android',region:'Asia',date:1511915606},
  {username:'liglesias2z', os:'iOS',region:'North America',date:1511910736},
  {username:'blapides30', os:'iOS',region:'North America',date:1511834165},
  {username:'brocco31', os:'Android',region:'Asia',date:1511843535},
  {username:'bfransson32', os:'iOS',region:'Asia',date:1511950614},
  {username:'mtruin33', os:'Android',region:'Asia',date:1511836499},
  {username:'jblumsom34', os:'iOS',region:'Africa',date:1511968840},
  {username:'aspaven35', os:'Android',region:'North America',date:1511993450},
  {username:'wbearman36', os:'iOS',region:'North America',date:1511923206},
  {username:'jedmeads37', os:'Android',region:'Oceania',date:1511892435},
  {username:'gcrannell38', os:'Android',region:'Asia',date:1511882976},
  {username:'kalyokhin39', os:'Android',region:'North America',date:1511906340},
  {username:'bdimont3a', os:'Android',region:'North America',date:1511920156},
  {username:'rgrimes3b', os:'Android',region:'Asia',date:1511965888},
  {username:'dstapforth3c', os:'Android',region:'North America',date:1511995414},
  {username:'cdemichele3d', os:'Android',region:'Asia',date:1511916208},
  {username:'mwestmore3e', os:'iOS',region:'Asia',date:1511835168},
  {username:'bpainten3f', os:'Android',region:'Europe',date:1511970318},
  {username:'norrick3g', os:'Android',region:'North America',date:1511991532},
  {username:'fhornig3h', os:'Android',region:'North America',date:1511956533},
  {username:'sandreolli3i', os:'Android',region:'Europe',date:1511922777},
  {username:'cvaszoly3j', os:'iOS',region:'Oceania',date:1511876161},
  {username:'slafee3k', os:'Android',region:'South America',date:1511843739},
  {username:'cmadeley3l', os:'iOS',region:'Europe',date:1511843182},
  {username:'favory3m', os:'iOS',region:'Africa',date:1511883130},
  {username:'mcoiley3n', os:'Android',region:'Africa',date:1511902253},
  {username:'naingell3o', os:'Android',region:'South America',date:1511980939},
  {username:'ayurkevich3p', os:'iOS',region:'South America',date:1511974031},
  {username:'ebuckell3q', os:'iOS',region:'Oceania',date:1511835476},
  {username:'abearcock3r', os:'iOS',region:'Europe',date:1511941238},
  {username:'jpavolini3s', os:'iOS',region:'Oceania',date:1511839078},
  {username:'zmorshead3t', os:'Android',region:'North America',date:1511876784},
  {username:'lderisley3u', os:'iOS',region:'Europe',date:1511909893},
  {username:'smettrick3v', os:'Android',region:'South America',date:1511879569},
  {username:'akew3w', os:'iOS',region:'South America',date:1511870862},
  {username:'hcattonnet3x', os:'iOS',region:'Oceania',date:1511905189},
  {username:'egolland3y', os:'Android',region:'Asia',date:1511923478},
  {username:'dgierth3z', os:'iOS',region:'South America',date:1511870688},
  {username:'ahelliker40', os:'Android',region:'North America',date:1511980965},
  {username:'areinisch41', os:'iOS',region:'Asia',date:1511930101},
  {username:'cblacksland42', os:'iOS',region:'North America',date:1511954871},
  {username:'sardling43', os:'Android',region:'North America',date:1511905535},
  {username:'apresnail44', os:'iOS',region:'South America',date:1511990641},
  {username:'jemig45', os:'Android',region:'Europe',date:1511896119},
  {username:'gmcfaul46', os:'iOS',region:'Africa',date:1511975640},
  {username:'tblampy47', os:'iOS',region:'North America',date:1511847811},
  {username:'ikingswood48', os:'iOS',region:'Oceania',date:1511911587},
  {username:'mschooley49', os:'Android',region:'South America',date:1511888292},
  {username:'epetrowsky4a', os:'iOS',region:'Africa',date:1511862479},
  {username:'bmulcock4b', os:'Android',region:'Europe',date:1511996700},
  {username:'sbinfield4c', os:'Android',region:'Oceania',date:1511941320},
  {username:'bbattison4d', os:'Android',region:'North America',date:1511933927},
  {username:'rgery4e', os:'iOS',region:'Oceania',date:1511888469},
  {username:'tmandal4f', os:'Android',region:'North America',date:1511980871},
  {username:'cwellwood4g', os:'Android',region:'North America',date:1511932282},
  {username:'djansens4h', os:'iOS',region:'South America',date:1511951844},
  {username:'bbalsom4i', os:'iOS',region:'Africa',date:1511967038},
  {username:'lgalle4j', os:'Android',region:'Africa',date:1511952959},
  {username:'jhazelhurst4k', os:'iOS',region:'Africa',date:1511961028},
  {username:'dledgeway4l', os:'Android',region:'South America',date:1511860395},
  {username:'ytofano4m', os:'Android',region:'Europe',date:1511977887},
  {username:'soldey4n', os:'iOS',region:'Oceania',date:1511923624},
  {username:'asyphus4o', os:'Android',region:'North America',date:1511894866},
  {username:'wbaines4p', os:'iOS',region:'Africa',date:1511956817},
  {username:'mbirtonshaw4q', os:'Android',region:'Africa',date:1511969299},
  {username:'tcopland4r', os:'iOS',region:'Africa',date:1511869167},
  {username:'wlochhead4s', os:'iOS',region:'Oceania',date:1511940316},
  {username:'owolfart4t', os:'iOS',region:'Oceania',date:1511948626},
  {username:'amillett4u', os:'iOS',region:'South America',date:1511896425},
  {username:'cdarnell4v', os:'Android',region:'Africa',date:1511855977},
  {username:'fjeskin4w', os:'iOS',region:'Oceania',date:1511975573},
  {username:'laneley4x', os:'iOS',region:'South America',date:1511854076},
  {username:'chassin4y', os:'iOS',region:'Africa',date:1511968973},
  {username:'pkorpal4z', os:'Android',region:'Europe',date:1511830362},
  {username:'aagutter50', os:'iOS',region:'Asia',date:1511970266},
  {username:'rloxton51', os:'iOS',region:'Africa',date:1511981301},
  {username:'srylstone52', os:'iOS',region:'North America',date:1511929110},
  {username:'bshakle53', os:'iOS',region:'South America',date:1511896005},
  {username:'jafield54', os:'Android',region:'South America',date:1511941294},
  {username:'btunniclisse55', os:'iOS',region:'Africa',date:1511907732},
  {username:'epellingar56', os:'Android',region:'Africa',date:1511848704},
  {username:'nfrapwell57', os:'Android',region:'Oceania',date:1511957371},
  {username:'amcwilliams58', os:'iOS',region:'Europe',date:1511903165},
  {username:'eabramovic59', os:'iOS',region:'North America',date:1511930084},
  {username:'jstewartson5a', os:'iOS',region:'South America',date:1511867947},
  {username:'rchowne5b', os:'Android',region:'Africa',date:1511828105},
  {username:'jgoldstraw5c', os:'Android',region:'South America',date:1511996049},
  {username:'mnoir5d', os:'Android',region:'Oceania',date:1511957759},
  {username:'acroom5e', os:'iOS',region:'Oceania',date:1511873733},
  {username:'cmacklin5f', os:'iOS',region:'Africa',date:1511972718},
  {username:'ldoche5g', os:'Android',region:'Africa',date:1511835467},
  {username:'cselley5h', os:'iOS',region:'North America',date:1511850860},
  {username:'amuttock5i', os:'iOS',region:'Africa',date:1511896322},
  {username:'bklement5j', os:'iOS',region:'Africa',date:1511834322}]

docs.each do |doc|              # every 10s, add a document to the database so that the dashboard can update in real time
  sleep(10)                     # and it appears that our userbase is growing steadily
  collection.insert_one(doc)
  puts 'Added user'
end



