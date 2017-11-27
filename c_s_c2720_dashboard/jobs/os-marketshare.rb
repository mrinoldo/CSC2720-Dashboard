require 'date'                                  # used to convert epoch timestamp to month
require 'mongo'                                 # used to connect to our mongodb database
require 'dotenv'                                # used to load environment variable for database credentials

Dotenv.load                                     # load environment variable that contains credentials to 
                                                # connect to database
Mongo::Logger.logger.level = ::Logger::FATAL
client = Mongo::Client.new(ENV['MONGOLAB_URI']) # connect to database

 
SCHEDULER.every '30s', :first_in => 0 do |job|          # reload dashoard every 30s

ios = client[:users].find({os: "iOS"}).count()          # query databse for number of documents with 'os' field equal to 'iOS'
android = client[:users].find({os: "Android"}).count()  # query databse for number of documents with 'os' field equal to 'Android'

array = [android, ios]                                  # create an array of two integers: the android count and the iOS count
source = 'http://some.remote.host/piechart.xml'

labels = ['Android', 'iOS']                             # this job creates a simple pie chart comparing two integer values

  data = [
    {
      data: array.values_at(0,1),                       # chart data consists of each value of the above array
      backgroundColor: [                                # the following lines are styling options
        '#F7464A',
        '#46BFBD'
      ],
      hoverBackgroundColor: [
        '#FF6384',
        '#36A2EB'
      ],
    },
  ]


  send_event('os-marketshare', { labels: labels, datasets: data })  # send the result of the job to the dashboard file

end

