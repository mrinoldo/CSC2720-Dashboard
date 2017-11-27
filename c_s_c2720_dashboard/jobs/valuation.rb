current_valuation = 0       # for the presentation, start the valuation at 0
SCHEDULER.every '30s' do
  last_valuation = current_valuation  # used to show percent growth/decline


  loop do                         # while loop to change the valuation for presentation
  current_valuation += rand(10)   # increment by random value between 1 and 10
  current_valuation -= rand(5)    # decrement by random value between 1 and 5, so that it appears to always be growing
  break if current_valuation >= 10 
end 

  send_event('valuation', { current: current_valuation, last: last_valuation }) # send result of job to dashboard file
end