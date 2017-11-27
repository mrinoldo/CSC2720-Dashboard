require 'date'                                  # used to convert epoch timestamp to month
require 'mongo'                                 # used to connect to our mongodb database
require 'dotenv'                                # used to load environment variable for database credentials

Dotenv.load                                     # load environment variable that contains credentials to 
                                                # connect to database
Mongo::Logger.logger.level = ::Logger::FATAL
client = Mongo::Client.new(ENV['MONGOLAB_URI']) # connect to database

 
SCHEDULER.every '30s', :first_in => 0 do |job|  # reload dashoard every 30s

date = []                               # initialize an empty array to hold dates

client[:users].find({"date" => {"$gt" => 1483228800 } }) # this date is 01/01/2017; query database for dates after this date
.projection({'date' => 1, '_id' => 0})  # .projection is how we specify which fields we want to return
.each { |item|                          # for each loop to return only the 'date' field, and leaving '_id' out
date = date.push(item['date'])}         # push each returned value to date array

# we now have an array full of epoch timestamps

months = date.map { |t| (Time.at(t).to_datetime).month()}   # extract month from epoch timestamp and map it to new array
# we now have an array of of months integers (1-12) that correspond with months (January-December)

# because we don't know if there is data from every month of the year, we create a hash map of placeholder values 0
# otherwise if, for example, we go from January to March, the dashboard won't know to skip February
monthPlaceholder = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0}
monthCount = months.uniq.map{|t| [t,months.count(t)]}.to_h  # convert the months array to a hashmap of consisting of the count of each month
# for example, this might look like {1 => 110, 2 => 212} if we had 110 downloads in January followed by 212 downloads in February; key,value pair of month,count
@monthMerged = monthPlaceholder.merge(monthCount)   # merge the monthCount hash map with the monthPlaceholder hash map
                                                    # the 0 placeholders will be overwritten if a value exists
labels = ['January', 'February', 'March', 'April', 'May', 'June', 
'July', 'August', 'September', 'October', 'November',]              # specify the labels for the chart, in this case we stop at November because the 
len = labels.length                                                 # presentation takes place in November

data = [
  {
    label: 'Unique downloads per month',
    data: @monthMerged.values,                                      # the data consists of the values of the monthsMerged hash map, (not the keys)
    backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * len,           # the following lines are styling options
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
            autoSkip: false                                     # forces chart to display each x-axis value
        }
    }]
}
}



send_event('downloads-per-month', { labels: labels, datasets: data, options: options })     # send the result of the job to the dashboard file

end 




