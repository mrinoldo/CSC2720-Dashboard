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


region = []

client[:users].find()
.projection({'region' =>1,  '_id' => 0})
.each { |item|
region = region.push(item['region'])}

regionCount = region.uniq.map{|t| [t,region.count(t)]}.to_h
regionCountSorted = Hash[regionCount.sort_by{|k, v| v}.reverse]
regionNames = regionCountSorted.keys

labels = regionNames
data = [
  {
    label: 'Users by Region',
    data: regionCountSorted.values,
    backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * labels.length,
    borderColor: [ 'rgba(255, 99, 132, 1)' ] * labels.length,
    borderWidth: 1,
  }
]
options = {
scales: {
    xAxes: [{
        stacked: false,
        beginAtZero: true,
        scaleLabel: {
            labelString: 'Region'
        },
        ticks: {
            stepSize: 1,
            min: 0,
            autoSkip: false
        }
    }]
}
}
send_event('regions', {labels: labels, datasets: data, options: options })
 end