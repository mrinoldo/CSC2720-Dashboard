current_valuation = 0

SCHEDULER.every '30s' do
  last_valuation = current_valuation

  loop do 
  current_valuation += rand(10)
  current_valuation -= rand(5)
  break if current_valuation >= 10
end 

  send_event('valuation', { current: current_valuation, last: last_valuation })
end