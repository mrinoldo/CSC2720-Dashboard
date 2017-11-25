require 'date'
require 'mongo'
require 'dotenv'

Dotenv.load

Mongo::Logger.logger.level = ::Logger::FATAL
client = Mongo::Client.new(ENV['MONGOLAB_URI'])

 
SCHEDULER.every '30s', :first_in => 0 do |job|

date = []

client[:users].find({"date" => {"$gt" => 1483228800 } }) # this date is 01/01/2017
.projection({'date' => 1, '_id' => 0})
.each { |item|
date = date.push(item['date'])}

months = date.map { |t| (Time.at(t).to_datetime).month()}
year = date.map { |t| (Time.at(t).to_datetime).year()}

monthPlaceholder = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0}
monthCount = months.uniq.map{|t| [t,months.count(t)]}.to_h
@monthMerged = monthPlaceholder.merge(monthCount)

labels = ['January', 'February', 'March', 'April', 'May', 'June', 
'July', 'August', 'September', 'October', 'November',]
len = labels.length

data = [
  {
    label: 'Unique downloads per month',
    data: @monthMerged.values,
    #backgroundColor: ('rgba(255, 99, 132, 0.2)') * labels.length,
    #borderColor: ('rgba(255, 99, 132, 1)') * labels.length,
    backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * len,
    borderColor: [ 'rgba(255, 99, 132, 1)' ] * len,
    pointBackgroundColor: "rgba(255, 99, 132, 1)",
    pointBorderColor: "#fff",
    pointHoverBackgroundColor: "rgba(255, 99, 132, 1)",
    pointHoverBorderColor: "rgba(255, 99, 132, 1)",
    borderWidth: 1
  }]
options = {
scales: {
    xAxes: [{
        stacked: false,
        beginAtZero: true,
        ticks: {
            stepSize: 1,
            min: 0,
            autoSkip: false
        }
    }]
}
}



send_event('downloads-per-month', { labels: labels, datasets: data, options: options })

end 




