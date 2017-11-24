require 'date'
require 'mongo'

Mongo::Logger.logger.level = ::Logger::FATAL

client_host = ['ds259085.mlab.com:59085']
client_options = {
  database: 'csc2720',
  user: 'csc2720',
  password: 'csc2720project',
}

client = Mongo::Client.new(client_host, client_options)

SCHEDULER.every '30s', :first_in => 0 do |job|

ios = client[:users].find({os: "iOS"}).count()
android = client[:users].find({os: "Android"}).count()

array = [android, ios]
source = 'http://some.remote.host/piechart.xml'

labels = ['Android', 'iOS']

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


  send_event('os-marketshare', { labels: labels, datasets: data })


puts ios
puts android

end

