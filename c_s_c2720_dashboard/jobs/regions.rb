require 'mongo'                                 # used to connect to our mongodb database
require 'dotenv'                                # used to load environment variable for database credentials

Dotenv.load                                     # load environment variable that contains credentials to 
                                                # connect to database
Mongo::Logger.logger.level = ::Logger::FATAL
client = Mongo::Client.new(ENV['MONGOLAB_URI']) # connect to database

 
SCHEDULER.every '30s', :first_in => 0 do |job|  # reload dashoard every 30s


region = []                                     # initialize an empty array to hold the counts per region                        

client[:users].find()                           # query database for every document
.projection({'region' =>1,  '_id' => 0})        # return only the values of the 'region' field
.each { |item|                                  # for each loop to push each returned value to the region array
region = region.push(item['region'])}

regionCount = region.uniq.map{|t| [t,region.count(t)]}.to_h     # map the values from the region array to a hash map containing the count of each region
# for example this might look like {'North America' => 1120, 'Europe' => 999}; key,value pair of region,count
regionCountSorted = Hash[regionCount.sort_by{|k, v| v}.reverse] # sort the hash map by value, descending
regionNames = regionCountSorted.keys                            # extract the region names from the sorted hash map so that we can give the bar chart the labels in order

labels = regionNames                                            # x-axis is region names (keys) sorted by their values (counts) in descending order from regionCountSorted hash map
data = [
  {
    label: 'Users by Region',
    data: regionCountSorted.values,                             # y-axis is values from regionCountSorted hash map
    backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * labels.length, # the following lines are styling options
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
send_event('regions', {labels: labels, datasets: data, options: options })  # send results of the job to the dashboard file
 end