require 'date'
require 'mongo'

module Client_3ci_completeVsInomplete
Mongo::Logger.logger.level = ::Logger::FATAL

client_host = ['ds259085.mlab.com:59085']
client_options = {
  database: 'csc2720',
  user: 'csc2720',
  password: 'csc2720project',
}

client = Mongo::Client.new(client_host, client_options)

@totalInvites = client[:users].find({"date" => {"$gt" => 1483228800 } }).count()
#@android = client[:users].find({os: "Android", "applicationDateUtc" => {"$gt" => 1483228800 }}).count()
@ios = client[:users].find({os: "iOS"}).count()
@android = client[:users].find({os: "Android"}).count()


#@ios = (@totalInvites - @android)

array = [@android, @ios]
source = 'http://some.remote.host/piechart.xml'

labels = ['Android', 'iOS']

#SCHEDULER.every '10s', :first_in => 0 do |job|

  data = [
    {
      data: array.values_at(0,1),
      backgroundColor: [
        '#F7464A',
        '#46BFBD'
      ],
      hoverBackgroundColor: [
        '#FF6384',
        '#36A2EB'
      ],
    },
  ]

# SCHEDULER.every '10m', :first_in => 0 do |job|

  send_event('os-marketshare', { labels: labels, datasets: data })

# end

  def self.ios
      return @ios
  end

  def self.android
      return @android
  end

puts self.ios
puts self.android

end

